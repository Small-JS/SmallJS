CLASS TestMyPerson EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS ''

test
	| person |
	person := MyPerson new.

	self assert: [ MyPerson columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert: [ person name = 'Test' ].

	person setPassword: 'secret'.
	self assert: [ person salt >= 0 ].
	self assert: [ person password length = 64 ].
	self assert: [ person checkPassword: 'secret' ].
!
