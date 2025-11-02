CLASS ShopServer EXTENDS Object MODULE ShopServer CLASSVARS ''
	VARS 'express server database personTable productTable orderTable'

"This app provides a Shop API for users, products and orders in the /api route.
It also provides a static web server for web content of the client.
It uses databases enabled in the '.env' file."

METHODS

async start
	Console log: 'Shop Server.'.
	await self connectDatabase.
	await self startServer.
!
async connectDatabase
	| connectionString |
	connectionString := Environment at: 'SHOP_DATABASE'.
	connectionString isNil ifTrue: [
		Error throw: 'Environment variable "SHOP_DATABASE" not set.' ].

	database := SqlDatabase newFor: connectionString.
	Console log: 'Connecting to database type: ', database class name.
	await database connect: connectionString.

	personTable := database connectTable: 'Person' rowClass: DbPerson.
	productTable := database connectTable: 'Product' rowClass: Product.
	orderTable := database connectTable: 'Order' rowClass: Order.
!
startServer
	| portString port clientPath |

	portString := Environment at: 'SHOP_PORT'.
	portString isNil ifTrue: [
		Error throw: 'Environment variable "SHOP_PORT" not set.' ].
	port := portString toInteger.
	( port < 1024 ) | ( port > 65535 ) ifTrue: [
		Error throw: 'Invalid port number: ', portString ].

	clientPath := Environment at: 'SHOP_CLIENT'.
	clientPath isNil ifTrue: [
		clientPath := '../Client/web'.
		Console log: 'Environment variable "SHOP_CLIENT" not set, defaulting to: ', clientPath ].
	Console log: 'Client path: ', clientPath.

	express := Express new.
	express useSession.
	express static: clientPath.
	express get: '/api/login'
		then: [ :request :response | self login: request response: response ].
	express get: '/api/products'
		then: [ :request :response | self products: request response: response ].
	express get: '/api/orders'
		then: [ :request :response | self orders: request response: response ].

	Console log: 'Starting webserver.'.
	server := express listen: port then: [ self onListen: port ].
!
onListen: port
	Console log: 'Server started on port: ', port toString.

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

async login: request response: response
	| person query dbPersons dbPerson |

	person := Person fromObject: request query.
	person name notNil ifFalse: [
		 ^ self sendLoginResponse: response success: false message: 'Login parameter "name" missing' ].
	person password notNil ifFalse: [
		^ self sendLoginResponse: response success: false message: 'Login parameter "password" missing' ].

	query := ( personTable quoted: 'name' ), ' = ', ( personTable parameter: 1 ).
	dbPersons := await personTable select: query with: #( ( person name ) ).
	dbPersons length > 0 ifFalse: [
		^ self sendLoginResponse: response success: false message: 'User not found: ', person name ].

	dbPerson := dbPersons first.
	( await dbPerson checkPassword: person password ) ifFalse: [
		^ self sendLoginResponse: response success: false message: 'Password check failed' ].

	request session set: 'user' to: dbPerson.
	self sendLoginResponse: response success: true message: 'Login succeeded'.
!
sendLoginResponse: response success: success message: message
	| loginResponse |
	loginResponse := LoginResponse success: success message: message.
	Console log: 'Sending login response: ', loginResponse toString.
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

async products: request response: response
	| products |
	( self checkRequestUser: request response: response ) ifFalse: [ ^ nil ].

	products := await productTable selectAll.
	response send: products toJsObject.
!

"Example orders request:
	localhost:3000/api/orders
 Will return an object with:
 	An array all orders for the logged-in user
 	and an array of all products associated with the orders."

async orders: request response: response
	| query user userId orders products result |

	user := self getRequestUser: request response: response.
	user isNil ifTrue: [ ^ nil ].

	query := ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ).
	userId := user id.
	orders := await orderTable select: query with: #( userId ).

	query := 'id in ( select ', ( orderTable quoted: 'product' ), ' from ', orderTable quotedName,
		' where ', ( orderTable quoted: 'person' ), ' = ', ( orderTable parameter: 1 ), ' )'.
	products := await productTable select: query with: #( userId ).

	result := Object new
		atProperty: 'orders' put: orders;
		atProperty: 'products' put: products.
	response send: result toJsObject.
!
async stop
	await server terminate.
	await database end.
!
