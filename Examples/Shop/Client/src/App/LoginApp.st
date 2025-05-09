CLASS LoginApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS ''
	VARS 'userNameInput passwordInput loginButton loginErrorSpan'

METHODS

start
	self references.
	self bindElements.

	"For easy access :-)"
	userNameInput value: 'John'.
	passwordInput value: 'secret'.

	self testMode ifTrue: [
		TestLoginApp new test: self ].
!
references
	"Prevent minimizing of apps for other HTML pages."
	^ true. 	"Don't actually execute the references now."
	ProductApp start.
	OrderApp start.
!
bindElements
	userNameInput := Document getElementById: 'userNameInput' class: HtmlInputElement.
	passwordInput := Document getElementById: 'passwordInput' class: HtmlInputElement.

	loginButton := Document getElementById: 'loginButton' class: HtmlButtonElement.
	loginButton onClick: [ :event | self onLogin ].

	loginErrorSpan := Document getElementById: 'loginErrorSpan' class: HtmlSpanElement.
!
onLogin
	| person loginApi |

	person := Person new
		name: userNameInput value;
		password: passwordInput value.
	loginApi := self url, '/api/login', person toQuery.

	Fetch
		object: loginApi
		then: [ :object | self onLoginResponse: object ]
		catch: [ :error | self onLoginError: error ] .
!
onLoginResponse: object
	| response |

	response := LoginResponse fromObject: object.
	self log: 'ShopServer login response: ', response toString.

	response success
		ifTrue: [ self navigateTo: '../Product/Product.html' ]
		ifFalse: [ loginErrorSpan textContent: response message ].
!
onLoginError: error
	loginErrorSpan textContent: error message.
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
