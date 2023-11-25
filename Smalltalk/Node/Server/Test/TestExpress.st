CLASS TestExpress EXTENDS Test MODULE TestServer CLASSVARS '' VARS 'express server port'

METHODS

test
	express := Express new.
	port := 3000.
	express get: '/login' then:
		[ :request :response | self onLoginRequest: request response: response ].

	server := express listen: port
		then: [ :error | self onExpressListen: error ].
!
onExpressListen: error
	| loginUrl |

	error isNil ifFalse: [ error throw ].

	loginUrl := 'http://localhost:', port toString, '/login?user=John&password=secret'.
	Http
		fetchObject: loginUrl
		then: [ :object | self onLoginResponse: object ]
		onError: [ :error | self onLoginError: error ] .
!
onLoginRequest: request response: response
	| user password |

	self assert: [ true ].	"Callback reached."

	user := request query atJsProperty: 'user'.
	self assert: [ user = 'John' ].

	password := request query atJsProperty: 'password'.
	self assert: [ password = 'secret' ].

	self sendLoginResponse: response success: true message: 'Login succeeded'.
!
sendLoginResponse: response success: success message: message
	| object |
	object := Object new
		atProperty: 'success' put: success;
		atProperty: 'message' put: message.

	response send: object.

	self assert: [ true ].
!
onLoginResponse: object
	self assert: [ object atProperty: 'success' ].

	self end.
!
onLoginError: error
	self error: error.

	self end.
!
end
	server terminate.
!
