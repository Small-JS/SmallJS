CLASS TestPerson EXTENDS Test MODULE TestShopShared CLASSVARS '' VARS ''

test
	| person |
	person := Person new.

	self assert: [ Person columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert:[ person name = 'Test' ].

	person password: 'secret'.
	self assert:[ person password = 'secret' ].
!
