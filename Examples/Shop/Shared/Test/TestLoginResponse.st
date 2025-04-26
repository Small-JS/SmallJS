CLASS TestLoginResponse EXTENDS Test MODULE TestShopShared CLASSVARS '' VARS ''

test
	| loginResponse object |

	loginResponse := LoginResponse success: true message: 'Success!'.
	self assert:[ loginResponse success ].
	self assert:[ loginResponse message = 'Success!' ].
	self assert:[ loginResponse toString = 'LoginResponse( success: true, message: Success! )' ].

	object := Object new
		atProperty: 'success' put: false;
		atProperty: 'message' put: 'Wrong password'.
	loginResponse := LoginResponse fromObject: object.
	self assert:[ loginResponse success not ].
	self assert:[ loginResponse message = 'Wrong password' ].

	loginResponse := LoginResponse new.
	loginResponse success: false.
	self assert:[ loginResponse success not ].

	loginResponse message: 'Failed!'.
	self assert:[ loginResponse message = 'Failed!' ].
!
