CLASS TestShopServer EXTENDS Object MODULE TestShopServer CLASSVARS '' VARS 'shopServer sessionCookie'

"Test ShopServer units and API.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aShopServer
	shopServer := aShopServer.

	"Force import of unit tests shared module."
	TestPerson.
	"Run sync and async unit tests of all imported Test* classes and log results."
	Test allThen: [
		self testApi ].
!
async testApi
	self log: 'Starting API tests.'.

	"The tests are chained end-to-start because they must run async."
	await self requestLogin.
	await self requestProducts.
	await self requestOrders.
	await self stopServer.
!
async requestLogin
	| person url response object loginResponse |
	person := Person new name: 'John'; password: 'secret'.
	url := 'http://localhost:3000/api/login', person toQuery.
	response := await Fetch request: url.
	self assert: [ response status = 200 ].

	object := await response json.
	loginResponse := LoginResponse fromObject: object.
	self assert: [ loginResponse success ].
	self assert: [ loginResponse message = 'Login succeeded' ].

	sessionCookie := response cookie.
	self assert: [ sessionCookie includes: 'connect.sid' ].

!
async requestProducts
	| objects products product |
	objects := await self fetchObject: 'http://localhost:3000/api/products'.

	"'objects' should contain an array of productss."
	self assert: [ objects length = 3 ].

	product := Product fromObject: objects first.
	self assert: [ product id = 1 ].
	self assert: [ product name = 'Apple' ].
	self assert: [ product price = 100 ].
!
async requestOrders
	| object orders order products product |
	object := await self fetchObject: 'http://localhost:3000/api/orders'.

	"'object' should contain properties 'orders' and 'products'
	 each containting an array of objects with values of the type indicated.
	 The products are the ones referenced by the orders."

	orders := object atProperty: 'orders'.
	self assert: [ orders class = Array ].
	self assert: [ orders length = 2 ].

	order := Order fromObject: orders first.
	self assert: [ order id = 1 ].
	self assert: [ order person = 1 ].
	self assert: [ order product = 1 ].
	self assert: [ order amount = 10 ].

	products := object atProperty: 'products'.
	self assert: [ products class = Array ].
	self assert: [ products length = 2 ].

	product := Product fromObject: products last.
	self assert: [ product id = 2 ].
	self assert: [ product name = 'Orange' ].
	self assert: [ product price = 150 ].
!
async fetchObject: url
	"Fetch array of objects while setting session cookie."
	| options headers |

	headers := Headers new
		set: 'cookie' value: sessionCookie.
	options := RequestInit new
		headers: headers.

	^ await Fetch object: url options: options.
!
async stopServer
	self log: 'API tests successful.'.
	self log: 'Stopping server.'.
	await shopServer stop.
!
