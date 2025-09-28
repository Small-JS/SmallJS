CLASS ShopServer EXTENDS Object MODULE ShopServer CLASSVARS '' VARS 'express server database personTable productTable orderTable'
	"This app provides a Shop API for users, products and orders in the /api route.
	 It also provides a static web server for web content of the client.
	 It uses databases enabled in the '.env' file.

	 Note: Within callbacks of pg functions, you cannot use return from block [ ^ x ].
	 	This will exit the application with unresolved promises vs. exceptions. "

METHODS

start
	self log: 'Shop Server.'.
	self connectDatabase.
!
connectDatabase
	| connectionString |

	connectionString := Environment at: 'SHOP_DATABASE'.
	connectionString isNil ifTrue: [
			self error: 'Environment variable "SHOP_DATABASE" not set.' ].

	database := SqlDatabase newFor: connectionString.
	self log: 'Connecting to database type: ', database class name.
	database connect: connectionString
		then: [ self connectTables ]
		catch: [ :error | error throw ].
!
connectTables
	personTable := database connectTable: 'Person' rowClass: DbPerson.
	productTable := database connectTable: 'Product' rowClass: Product.
	orderTable := database connectTable: 'Order' rowClass: Order.

	self startServer.
!
startServer
	| portString port clientPath |

	portString := Environment at: 'SHOP_PORT'.
	portString isNil ifTrue: [
		self error: 'Environment variable "SHOP_PORT" not set.' ].
	port := portString toInteger.
	( port <= 0 ) | ( port >= 65536 ) ifTrue: [
		self error: 'Invalid port number: ', portString ].

	clientPath := Environment at: 'SHOP_CLIENT'.
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
	localhost:3000/api/login?name=John&password=secret
 Example LoginResponse:
 	{ success: true, message: 'Login succeeded' }"

login: request response: response
	| person |
	person := Person fromObject: request query.
	person name isNil
		ifTrue: [ self sendLoginResponse: response success: false message: 'Login parameter "name" missing' ]
		ifFalse: [
			person password isNil
				ifTrue: [ self sendLoginResponse: response success: false message: 'Login parameter "password" missing' ]
				ifFalse: [ self login2: request response: response person: person ] ].
!
login2: request response: response person: person
	| query |
	"Note: Return from block is not allowed in Postgres callbacks."
	query := ( personTable quoted: 'name' ), ' = ', ( personTable parameter: 1 ).
	personTable select: query
		with: #( ( person name ) )
		then: [ :dbPersons | self login3: request response: response person: person dbPersons: dbPersons ]
		catch: [ :error | error throw ].
!
login3: request response: response person: person dbPersons: dbPersons
	dbPersons length < 1
		ifTrue: [ self sendLoginResponse: response success: false message: 'User not found: ', person name ]
		ifFalse: [ self login4: request response: response person: person dbPerson: dbPersons first ].
!
login4: request response: response person: person dbPerson: dbPerson
	( dbPerson checkPassword: person password ) not
		ifTrue: [ self sendLoginResponse: response success: false message: 'Password check failed' ]
		ifFalse: [
			request session set: 'user' to: dbPerson.
			self sendLoginResponse: response success: true message: 'Login succeeded' ].
!
sendLoginResponse: response success: success message: message
	| loginResponse |
	loginResponse := LoginResponse success: success message: message.
	self log: 'Sending login response: ', loginResponse toString.
	response send: loginResponse.
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

	productTable
		selectAllThen: [ :products | response send: products toJsObject ]
		catch: [ :error | error throw ].
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
	orderTable select: query
		with: #( userId )
		then: [ :orders |
			query := 'id in ( select ', ( orderTable quoted: 'product' ), ' from ', orderTable quotedName,
				' where ', ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ), ' )'.
			productTable select: query
				with: #( userId )
				then: [ :products |
					result := Object new
						atProperty: 'orders' put: orders;
						atProperty: 'products' put: products.
					response send: result toJsObject ]
				catch: [ :error | error throw ] ]
		catch: [ :error | error throw ].
!
stop
	server terminate.
	database end.
!
