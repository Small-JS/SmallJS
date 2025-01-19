CLASS TestProduct EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

test
	| product |
	product := Product new.

	self assert: [ product class columns first = #( 'name' String ) ].

	product name: 'Test'.
	self assert:[ product name = 'Test' ].

	product price: 123.
	self assert:[ product price = 123 ].
!
