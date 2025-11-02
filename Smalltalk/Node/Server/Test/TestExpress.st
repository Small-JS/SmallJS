CLASS TestExpress EXTENDS Test MODULE TestServer CLASSVARS '' VARS 'express server sessionCookie'

"Also tests class Server."

METHODS

test
	express := Express new.
	express useSession.

	express get: '/login'
		then: [ :request :response | self onLoginRequest: request response: response ].
	express get: '/products'
		then: [ :request :response | self onProductsRequest: request response: response ].

	server := express listen: 3000
		then: [ :error | self onExpressListen: error ].
!
async onExpressListen: error
	error isNil ifFalse: [ error throw ].

	await self requestLogin.
	await self requestProducts.
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
