CLASS LoginApp EXTENDS ShopApp MODULE ShopClient CLASSVARS ''
	VARS 'loginForm userNameInput passwordInput loginButton'

METHODS

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

	"Submitting the form (login button or Enter key) logs in, without reloading the page."
	loginForm := Document getElementById: 'loginForm' class: HtmlFormElement.
	loginForm addEventListener: 'submit' then: [ :event |
		event preventDefault.
		self login ].
!
async login
	| person object response |

	person := Person new
		name: userNameInput value;
		password: passwordInput value.
	object := await self fetchApi: '/api/login' options: ( self loginOptions: person ).
	object ifNil: [ ^ nil ].

	response := LoginResponse fromObject: object.
	self log: 'ShopServer login response: ', response toString.

	response success
		ifTrue: [ self navigateTo: '../Product/Product.html' ]
		ifFalse: [ self showError: response message ].
!
loginOptions: person
	"Return the options of a POST request to log in as person.
	 The credentials are sent in the JSON body, not in the URL,
	 so they do not end up in browser history or server logs."
	^ RequestInit new
		method: 'POST';
		headers: ( Headers new set: 'content-type' value: 'application/json' );
		body: person toLoginJson.
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
