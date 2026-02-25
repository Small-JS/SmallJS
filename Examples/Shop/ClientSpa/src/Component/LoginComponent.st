CLASS LoginComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'userNameInput passwordInput loginButton loginErrorSpan'

htmlPath
	^ 'Login/Login.html'.
!
start
	self bindElements.

	"For easy access :-)"
	userNameInput value: 'John'.
	passwordInput value: 'secret'.
!
bindElements
	userNameInput := Document getElementById: 'userNameInput' class: HtmlInputElement.
	passwordInput := Document getElementById: 'passwordInput' class: HtmlInputElement.

	loginButton := Document getElementById: 'loginButton' class: HtmlButtonElement.
	loginButton onClick: [ :event | self onLogin ].

	loginErrorSpan := Document getElementById: 'loginErrorSpan' class: HtmlSpanElement.
!
async onLogin
	| person loginApi object response |

	person := Person new
		name: userNameInput value;
		password: passwordInput value.
	loginApi := self app url, '/api/login', person toQuery.
	object := await Fetch object: loginApi.

	response := LoginResponse fromObject: object.
	self log: 'ShopServer login response: ', response toString.

	response success
		ifTrue: [ self app loadComponent: ProductComponent ]
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
