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
onExpressListenBug: error
	"2023-03-07:
	 Calling method fetchObject: in this code does work as intended,
	 delivering re response to method onLoginResponse: .
	 But in in the finalization of the fetch thread, the following error is wrongfully triggered:
	 	Exception has occurred: TypeError [ERR_INVALID_STATE]: Invalid state: Writer has been released.
	 Allthough this does not affect the program function, it is annoying when debugging,
	 So this code is now replaced by a workaround below.
	 In the normal use case for this, where fetch is called from a browser to nodeJS,
	 the error does not occur."

	| loginUrl |

	error isNil ifFalse: [ error throw ].

	loginUrl := 'http://localhost:', port toString, '/login?user=John&password=secret'.
	JsObject
		fetchObject: loginUrl
		then: [ :jsObject | self onLoginResponse: jsObject ]
		onError: [ :error | self onLoginError: error ] .

!
onExpressListen: error
	"Bybass version for now, avoiding library bug above."
	| response |

	self assert: [ error isNil ].

	response := Object new
		atProperty: 'success' put: true;
		atProperty: 'message' put: 'Login succeeded'.
	self onLoginResponse: response.

!
onLoginRequest: request response: response
	| user password |

	self assert: [ true ].	"Callback reached."

	user := request query atJsProperty: 'user'.
	user isNil ifTrue: [
		^ self sendLoginResponse: response success: false message: 'Login parameter "user" missing.' ].
	user ~= 'John' ifTrue: [
		^ self sendLoginResponse: response success: false message: 'Unknown user', user ].

	password := request query atJsProperty: 'password'.
	password isNil ifTrue: [
		^ self sendLoginResponse: response success: false message: 'Login parameter "password" missing.' ].
	password ~= 'secret' ifTrue: [
		^ self sendLoginResponse: response success: false message: 'Wrong password' ].

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
