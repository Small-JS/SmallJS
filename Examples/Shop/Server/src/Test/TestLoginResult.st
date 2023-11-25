CLASS TestLoginResult EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

test
	| loginResult object |

	loginResult := LoginResult success: true message: 'Success!'.
	self assert:[ loginResult success ].
	self assert:[ loginResult message = 'Success!' ].

	object := Object new
		atProperty: 'success' put: false;
		atProperty: 'message' put: 'Wrong password'.
	loginResult := LoginResult fromObject: object.
	self assert:[ loginResult success not ].
	self assert:[ loginResult message = 'Wrong password' ].

	loginResult := LoginResult new.
	loginResult success: false.
	self assert:[ loginResult success not ].

	loginResult message: 'Failed!'.
	self assert:[ loginResult message = 'Failed!' ].
!
