CLASS TestOrder EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

test
	| order |

	self assert:[ Order columns = #( 'person' 'product' 'amount' ) ].

	order := Order new.

	order person: 1.
	self assert:[ order person = 1 ].

	order product: 2.
	self assert:[ order product = 2 ].

	order amount: 100.
	self assert:[ order amount = 100 ].
!
