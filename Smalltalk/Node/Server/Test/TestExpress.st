CLASS TestExpress EXTENDS Test MODULE TestServer CLASSVARS '' VARS 'express server sessionCookie'

"Also tests class Server."

METHODS

test
	express := Express new.
	express useSession.
	express useJson.
	express useCors.

	express get: '/login'
		then: [ :request :response | self onLoginRequest: request response: response ].
	express get: '/products'
		then: [ :request :response | self onProductsRequest: request response: response ].
	express post: '/order'
		then: [ :request :response | self onOrderRequest: request response: response ].

	server := express listen: 3000
		then: [ :error | self onExpressListen: error ].
!
async onExpressListen: error
	error isNil ifFalse: [ error throw ].

	await self requestLogin.
	await self requestProducts.
	await self requestOrder.
	await self requestCors.
	server terminate.
!

"=============================== Login"

async requestLogin
	| url response text |

	url := 'http://localhost:3000/login?name=John&password=secret'.
	response := await Fetch request: url.

	text := await response text.
	self assert: [ text = 'Login succeeded' ].

	sessionCookie := response cookie.
	self assert: [ sessionCookie includes: 'connect.sid' ].
!
onLoginRequest: request response: response
	| name password |

	name := request query atProperty: 'name'.
	self assert: [ name = 'John' ].

	password := request query atProperty: 'password'.
	self assert: [ password = 'secret' ].

	self assert: [ ( request sessionId isKindOf: String ) and: [ request sessionId length > 0 ] ].
	request session set: 'loggedIn' to: true.
	response send: 'Login succeeded'.
!

"=============================== Products"

async requestProducts
	| headers options url text |

	headers := Headers new
		set: 'cookie' value: sessionCookie.
	options := RequestInit new
		headers: headers.

	url := 'http://localhost:3000/products'.
	text := await Fetch text: url options: options.
	self assert: [ text = 'Apple, Orange, Pear' ].
!
onProductsRequest: request response: response
	| loggedIn |
	loggedIn := ( request session get: 'loggedIn' ) = true.
	loggedIn
		ifFalse: [ response send: 'Not logged in' ]
		ifTrue: [ response send: 'Apple, Orange, Pear' ].
!

"=============================== Order"

async requestOrder
	| order headers options url object response |

	order := Object new
		atProperty: 'products' put: #( 'Apple' 'Pear' ).
	headers := Headers new
		set: 'content-type' value: 'application/json'.
	options := RequestInit new
		method: 'POST';
		headers: headers;
		body: order toJson.

	url := 'http://localhost:3000/order'.
	object := await Fetch object: url options: options.
	self assert: [ ( object atProperty: 'count' ) = 2 ].

	"Invalid JSON is answered with status 400."
	options body: '{ invalid'.
	response := await Fetch request: url options: options.
	self assert: [ response status = 400 ].
!
onOrderRequest: request response: response
	| products result |
	self assert: [ request method = 'POST' ].
	products := request body atProperty: 'products'.
	self assert: [ products = #( 'Apple' 'Pear' ) ].

	result := Object new
		atProperty: 'count' put: products length.
	response send: result.
!

"=============================== CORS"

async requestCors
	| url response options |

	url := 'http://localhost:3000/products'.
	response := await Fetch request: url.
	self assert: [ ( response headers get: 'access-control-allow-origin' ) = '*' ].

	"Preflight request."
	options := RequestInit new
		method: 'OPTIONS';
		headers: ( Headers new set: 'access-control-request-headers' value: 'content-type' ).
	response := await Fetch request: url options: options.
	self assert: [ response status = 204 ].
	self assert: [ ( response headers get: 'access-control-allow-origin' ) = '*' ].
	self assert: [ ( response headers get: 'access-control-allow-headers' ) = 'content-type' ].
	self assert: [ ( response headers get: 'access-control-allow-methods' ) includes: 'POST' ].
!
