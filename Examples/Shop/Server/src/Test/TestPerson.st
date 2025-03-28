CLASS TestPerson EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

test
	| person |
	person := Person new.

	self assert: [ person class columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert:[ person name = 'Test' ].

	person setPassword: 'secret'.
	self assert:[ person checkPassword: 'secret' ].
	self assert:[ person salt >= 0 ].
	self assert:[ person password length = 64 ].
!
