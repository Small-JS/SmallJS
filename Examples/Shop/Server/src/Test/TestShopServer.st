CLASS TestShopServer EXTENDS Object MODULE TestShopServer CLASSVARS '' VARS 'shopServer timer cookie'

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
testApi
	self log: 'Starting API tests.'.

	"The tests are chained end-to-start because they must run async."
	self requestLogin.
!
requestLogin
	| person |
	person := Person new name: 'John'; password: 'secret'.

	Fetch
		request: 'http://localhost:3000/api/login', person toQuery
		then: [ :response | self onLoginResponse: response ]
		catch: [ :error | error throw ] .

	timer := Timer timeout: 5000 then: [
			Error throw: 'Fetch login timer expired' ].
!
onLoginResponse: response
	timer clearTimeout.

	self assert: [ response status = 200 ].
	response jsonThen: [ :object | self onLoginResponse2: response object: object ].
!
onLoginResponse2: response object: object
	| result |
	result := LoginResponse fromObject: object.
	self assert: [ result success ].
	self assert: [ result message = 'Login succeeded' ].

	cookie := response cookie.
	self assert: [ cookie includes: 'connect.sid' ].

	self requestProducts.
!
requestProducts
	self fetchObject: 'http://localhost:3000/api/products'
		then: [ :objects | self onProductsResponse: objects ].

	timer := Timer timeout: 5000 then: [
			Error throw: 'Fetch products timer expired' ].
!
onProductsResponse: objects
	| products product |

	timer clearTimeout.

	self assert: [ objects length = 3 ].

	product := Product fromObject: objects first.
	self assert: [ product id = 1 ].
	self assert: [ product name = 'Apple' ].
	self assert: [ product price = 100 ].

	self requestOrders.
!
requestOrders
	self fetchObject: 'http://localhost:3000/api/orders'
		then: [ :objects | self onOrdersResponse: objects ].

	timer := Timer timeout: 5000 then: [
			Error throw: 'Fetch orders timer expired' ].
!
onOrdersResponse: object
	"'object' should contain properties 'orders' and 'products'
	 each containting an array of objects with values of the type indicated.
	 The products are the ones referenced by the orders."

	| orders products order product |

	timer clearTimeout.

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

	self stopServer.
!
fetchObject: url then: block
	"Fetch object while setting cookie."
	| options headers |

	headers := Headers new
		set: 'cookie' value: cookie.
	options := RequestInit new
		headers: headers.

	Fetch
		object: url
		options: options
		then: [ :objects | block value: objects ]
		catch: [ :error | error throw ] .
!
stopServer
	self log: 'API tests successful.'.
	self log: 'Stopping server.'.
	Timer timeout: 1000 then: [
		shopServer stop ].

!
