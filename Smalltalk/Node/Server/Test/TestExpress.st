CLASS TestExpress EXTENDS Test MODULE TestServer CLASSVARS '' VARS 'express server port cookie'
	"Tests classes: Express, Server, Fetch."

METHODS

test
	express := Express new.
	express useSession.

	express get: '/login' then:
		[ :request :response | self onLoginRequest: request response: response ].
	express get: '/products' then:
		[ :request :response | self onProductsRequest: request response: response ].

	port := 3000.
	server := express listen: port
		then: [ :error | self onExpressListen: error ].
!
onExpressListen: error
	error isNil ifFalse: [ error throw ].

	self requestLogin.
!

"=============================== Login"

requestLogin
	| loginUrl |

	loginUrl := 'http://localhost:', port toString, '/login?user=John&password=secret'.
	Fetch
		request: loginUrl
		then: [ :response | self onLoginResponse: response ]
		catch: [ :error | error throw ] .
!
onLoginRequest: request response: response
	| user password |

	user := request query atJsProperty: 'user'.
	self assert: [ user = 'John' ].
	password := request query atJsProperty: 'password'.
	self assert: [ password = 'secret' ].

	request session set: 'loggedIn' to: true.

	response send: 'Login succeeded'.
!
onLoginResponse: response
	response textThen: [ :text |
		self assert: [ text = 'Login succeeded' ].

		cookie := response cookie.
		self assert: [ cookie includes: 'connect.sid' ].

		self requestProducts ].
!

"=============================== Products"

requestProducts
	| url options headers |

	headers := Headers new
		set: 'cookie' value: cookie.
	options := RequestOptions new
		headers: headers.

	url := 'http://localhost:', port toString, '/products'.
	Fetch text: url options: options
		then: [ :response | self onProductsResponse: response ]
		catch: [ :error | error throw ] .
!
onProductsRequest: request response: response
	| loggedIn |

	loggedIn := ( request session get: 'loggedIn' ) = true.
	loggedIn
		ifFalse: [ response send: 'Not logged in' ]
		ifTrue: [ response send: 'Apple, Orange, Pear' ].

!
onProductsResponse: string
	self assert: [ string = 'Apple, Orange, Pear' ].

	self end.
!

"=============================== End "

end
	server terminate.
!
