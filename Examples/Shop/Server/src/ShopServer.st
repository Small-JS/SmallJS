CLASS ShopServer EXTENDS Object MODULE ShopServer CLASSVARS '' VARS 'express server database personTable productTable orderTable'
	"This app provides a Shop API for users, products and orders in the /api route.
	 It alse provites a stetic http server for that content.
	 It uses Postgres a back-end database, with the 'pg' npm library, so both should be installed.

	 Note: Within callbacks of pg functions, you cannot use return from block [ ^ x ].
	 	This will exit the application with unresolved promises vs exceptions. "

METHODS

start
	self log: 'Shop Server.'.
	self connectDatabase.
!
connectDatabase
	| connectionString |

	connectionString := Process envAt: 'SHOP_DATABASE'.
	connectionString isNil ifTrue: [
			self error: 'Environment variable "SHOP_DATABASE" not set.' ].

	database := SqlDatabase newFor: connectionString.
	self log: 'Connecting to database type: ', database class name.
	database connect: connectionString then: [ self connectTables ].
!
connectTables
	personTable := database connectTable: 'Person' rowClass: Person.
	productTable := database connectTable: 'Product' rowClass: Product.
	orderTable := database connectTable: 'Order' rowClass: Order.

	self startServer.
!
startServer
	| portString port clientPath |

	portString := Process envAt: 'SHOP_PORT'.
	portString isNil ifTrue: [
		self error: 'Environment variable "SHOP_PORT" not set.' ].
	port := portString toInteger.
	( port <= 0 ) | ( port >= 65536 ) ifTrue: [
		self error: 'Invalid port number: ', portString ].

	clientPath := Process envAt: 'SHOP_CLIENT'.
	clientPath isNil ifTrue: [
		clientPath := '../Client/web'.
		self log: 'Environment variable "SHOP_CLIENT" not set, defaulting to: ', clientPath ].
	self log: 'Client path: ', clientPath.

	express := Express new.
	express useSession.
	express static: clientPath.
	express get: '/api/login'
		then: [ :request :response | self login: request response: response ].
	express get: '/api/products'
		then: [ :request :response | self products: request response: response ].
	express get: '/api/orders'
		then: [ :request :response | self orders: request response: response ].

	self log: 'Starting webserver.'.
	server := express listen: port then: [ self onListen: port ].
!
onListen: port
	self log: 'Server started on port: ', port toString.

	self testMode ifTrue: [
		TestShopServer new test: self ].
!
testMode
	^ Process argv length >= 3 and: [ ( Process argv at: 2 ) = '-test' ].
!
"Example login request:
	localhost:3000/api/login?user=John&password=secret
 Example result:
 	{ true, 'Login succeeded' }"

login: request response: response
	| result userName password query person |

	result := LoginResult success: false message: 'Unknown'.

	userName := request query atJsProperty: 'user'.
	userName isNil
		ifTrue: [ response send: ( result message: 'Login parameter "user" missing' ) ]
		ifFalse: [
			password := request query atJsProperty: 'password'.
			password isNil
				ifTrue: [ response send: ( result message: 'Login parameter "password" missing' ) ]
				ifFalse: [
					query := ( personTable quoted: 'name' ), ' = ', ( personTable parameter: 1 ).
					personTable query: query  with: #( userName ) then: [ :persons |
						"Note: Block returns are not allowed in pg callbacks."
						persons length < 1
							ifTrue: [ response send: ( result message: 'User not found: ', userName ) ]
							ifFalse: [
								person := persons first.
								( person checkPassword: password ) not
									ifTrue: [ response send: ( result message: 'Password check failed' ) ]
									ifFalse: [
										request session set: 'user' to: person.
										response send: ( result success: true; message: 'Login succeeded' ) ] ] ] ] ].
!
getRequestUser: request response: response
	"Returns the logged-in user (Person) from the request or nil if it does not exist.
 	 If the user is not found, a server response 500 is sent also.
 	 Requests can only contain serialized data, so the ST object has to be reconstructed from that."

	| userObject |
	userObject := request session get: 'user'.
	userObject isNil ifTrue: [
		response sendStatus: 500 message: 'Not logged in.'.
		^ nil ].

	^ Person fromObject: userObject.
!
checkRequestUser: request response: response
	^ ( self getRequestUser: request response: response ) notNil.
!

"Example products request:
	localhost:3000/api/products
returns:
	'[ { 'id': 1, 'name' : 'Apple', 'price': 100 },
		{ 'id': 2, 'name': 'Orange', 'price': 150 },
		{ 'id': 3, 'name': 'Mango', 'price': 220 } ]'
"

products: request response: response
	( self checkRequestUser: request response: response ) ifFalse: [ ^ nil ].

	productTable queryAllThen:
		[ :products | response send: products toJsObject ].
!

"Example orders request:
	localhost:3000/api/orders
 Will return an object with:
 	An array all orders for the logged-in user
 	and an array of all products associated with the orders."

orders: request response: response
	| query user userId result |

	user := self getRequestUser: request response: response.
	user isNil ifTrue: [ ^ nil ].

	query := ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ).
	userId := user id.
	orderTable query: query with: #( userId ) then: [ :orders |
		query := 'id in ( select ', ( orderTable quoted: 'product' ), ' from ', orderTable quotedName,
			' where ', ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ), ' )'.
		productTable query: query with: #( userId )
			then: [ :products |
				result := Object new
					atProperty: 'orders' put: orders;
					atProperty: 'products' put: products.
				response send: result toJsObject ] ].
!
stop
	server terminate.
	database end.
!
