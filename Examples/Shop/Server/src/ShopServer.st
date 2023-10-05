CLASS ShopServer EXTENDS Object MODULE ShopServer CLASSVARS '' VARS 'express server user database personTable productTable orderTable'
	"This app provides a Shop API for users, products and orders in the /api route.
	 It alse provites a stetic http server for that content.
	 It uses Postgres a back-end database, with the 'pg' npm library, so both should be installed.

	 Note: Within callbacks of pg functions, you cannot use return from block [ ^ x ].
	 	This will exit the application with unresolved promises vs exceptions. "

METHODS

start
	self connectDatabase
!
connectDatabase
	| connectionString |

	connectionString := Process envAt: 'SHOP_DATABASE'.
	connectionString isNil ifTrue: [
			self error: 'Environment variable "SHOP_DATABASE" not set.' ].

	database := SqlDatabase newFor: connectionString.
	database connect: connectionString then: [ self connectTables ].
!
connectTables
	personTable := database connectTable: 'Person' rowClass: Person.
	productTable := database connectTable: 'Product' rowClass: Product.
	orderTable := database connectTable: 'Order' rowClass: Order.

	self startServer.
!
startServer
	| portString port |

	portString := Process envAt: 'SHOP_PORT'.
	portString isNil ifTrue: [
		self error: 'Environment variable "SHOP_PORT" not set.' ].
	port := portString toInteger.
	( port <= 0 ) | ( port >= 65536 ) ifTrue: [
		self error: 'Invalid port number: ', portString ].

	express := Express new.
	express static: '../Client/web'.
	express get: '/api/login'
		then: [ :request :response | self login: request response: response ].
	express get: '/api/products'
		then: [ :request :response | self products: request response: response ].
	express get: '/api/orders'
		then: [ :request :response | self orders: request response: response ].

	server := express listen: port
		then: [ self log: 'Started Shop server on port: ', port toString ].
!

"Example login request:
	localhost:3000/api/login?user=John&password=secret"

login: request response: response
	| userName password query person |

	userName := request query atJsProperty: 'user'.
	userName isNil ifTrue: [
		^ self sendLoginResponse: response success: false message: 'Login parameter "user" missing.' ].

	password := request query atJsProperty: 'password'.
	password isNil ifTrue: [
		^ self sendLoginResponse: response success: false message: 'Login parameter "password" missing.' ].

	query := ( personTable quoted: 'name' ), ' = ', ( personTable parameter: 1 ).
	"Note: Block returns are not allowed in pg callbacks."
	personTable query: query  with: #( userName )
		then: [ :persons |
			persons length < 1
				ifTrue: [ self sendLoginResponse: response success: false message: 'User not found: ', userName ]
				ifFalse: [
					person := persons first.
					( person checkPassword: password ) not
						ifTrue: [ self sendLoginResponse: response success: false message: 'Password check failed' ]
						ifFalse: [
							self sendLoginResponse: response success: true message: 'Login succeeded'.
							user := person ] ] ].
!

"Example login response:
	{ 'success' : true, 'message' : 'Login succeeded' }"

sendLoginResponse: response success: success message: message
	| jsResponse |
	jsResponse := JsObject newEmpty
		atJsProperty: 'success' put: success;
		atJsProperty: 'message' put: message.

	response send: jsResponse.
!
checkLogin
	^ user class = Person.
!
notLoggedIn: response
	response sendStatus: 500 message: 'Not logged in.'
!

"Example products request:
	localhost:3000/api/products
returns:
	'[ { 'id': 1, 'name' : 'Apple', 'price': 100 },
		{ 'id': 2, 'name': 'Orange', 'price': 150 },
		{ 'id': 3, 'name': 'Mango', 'price': 220 } ]'
"

products: request response: response
	self checkLogin ifFalse: [
		^ self notLoggedIn: response ].

	productTable queryAllThen:
		[ :products | response send: products toJsObject ].
!

"Example orders request:
	localhost:3000/api/orders
 Will return an object with:
 	An array all orders for the logged-in user
 	and an array of all products associated with the orders."

orders: request response: response
	| query userId result |

	self checkLogin ifFalse: [
		^ self notLoggedIn: response ].

	query := ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ).
	userId := user id.
	orderTable query: query with: #( userId )
		then: [ :orders |
			query := 'id in ( select ', ( orderTable quoted: 'product' ), ' from ', orderTable quotedName,
				' where ', ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ), ' )'.
			productTable query: query with: #( userId )
				then: [ :products |
					result := Object new
						atProperty: 'orders' put: orders;
						atProperty: 'products' put: products.
					response send: result toJsObject ] ].
!
