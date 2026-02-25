CLASS LoginApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS ''
	VARS 'userNameInput passwordInput loginButton loginErrorSpan'

METHODS

start
	self references.
	self bindElements.

	"For easy access :-)"
	userNameInput value: 'John'.
	passwordInput value: 'secret'.
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
	loginButton onClick: [ :event | self login ].

	loginErrorSpan := Document getElementById: 'loginErrorSpan' class: HtmlSpanElement.
!
async login
	| person loginApi object response |

	person := Person new
		name: userNameInput value;
		password: passwordInput value.
	loginApi := self url, '/api/login', person toQuery.
	object := await Fetch object: loginApi.

	response := LoginResponse fromObject: object.
	self log: 'ShopServer login response: ', response toString.

	response success
		ifTrue: [ self navigateTo: '../Product/Product.html' ]
		ifFalse: [ loginErrorSpan textContent: response message ].
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
