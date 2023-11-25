CLASS LoginApp EXTENDS ClientApp MODULE ShopClient CLASSVARS ''
	VARS 'userNameInput passwordInput loginButton loginErrorLabel'

METHODS

start
	self bindElements.

	"For easy access :-)"
	userNameInput value: 'John'.
	passwordInput value: 'secret'.

	self testMode ifTrue: [
		TestLoginApp new test: self ].
!
bindElements
	userNameInput := Document default getElementById: 'userNameInput'.
	self assert: [ userNameInput class = HtmlInputElement ].

	passwordInput := Document default getElementById: 'passwordInput'.
	self assert: [ passwordInput class = HtmlInputElement ].

	loginButton := Document default getElementById: 'loginButton'.
	self assert: [ loginButton class = HtmlButtonElement ].
	loginButton onClick: [ :event | self onLogin ].

	loginErrorLabel := Document default getElementById: 'loginErrorLabel'.
	self assert: [ loginErrorLabel class = HtmlLabelElement ].
!
onLogin
	| userName password loginApi |

	userName := userNameInput value.
	password := passwordInput value.
	loginApi := self url, '/api/login?user=', userName, '&password=', password.

	Object
		fetchObject: loginApi
		then: [ :object | self onLoginResponse: object ]
		onError: [ :error | self onLoginError: error ] .
!
onLoginResponse: object
	| success message |

	success := object atProperty: 'success'.
	message := object atProperty: 'message'.
	self log: 'ShopServer login response: ', success, ', message: ', message.

	success
		ifTrue: [ self navigateTo: '../Product/Product.html' ]
		ifFalse: [ loginErrorLabel textContent: message ].
!
onLoginError: error
	loginErrorLabel textContent: error message.
!

"Accessing (used by tests)"

userNameInput
	^ userNameInput.
!
passwordInput
	^ passwordInput.
!
loginButton
	^ loginButton.
!
