CLASS ShopLogin EXTENDS Object MODULE ShopClient CLASSVARS ''
	VARS 'userNameTextBox passwordTextBox loginButton loginErrorLabel'

METHODS

start
	| document |

	document := Document default.
	userNameTextBox := document getElementById: 'userNameTextBox'.
	passwordTextBox := document getElementById: 'passwordTextBox'.
	loginButton := document getElementById: 'loginButton'.
	loginButton addEventListener: 'click' then: [ :event | self onLogin ].
	loginErrorLabel := document getElementById: 'loginErrorLabel'.

	userNameTextBox value: 'John'.
	passwordTextBox value: 'secret'.
!
onLogin
	| userName password location loginApi |

	userName := userNameTextBox value.
	password := passwordTextBox value.

	location := Window default location.
	loginApi :=  location protocol, '//', location host, '/api/login?user=', userName, '&password=', password.
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

	success ifTrue: [ Window default location href: '../Product/Product.html' ]
		ifFalse: [  loginErrorLabel textContent: message ].
!
onLoginError: error
	self log: error.
!
