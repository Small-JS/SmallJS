CLASS TestOrder EXTENDS Test MODULE TestShopClient CLASSVARS '' VARS ''

testColumns
	self assert: [ Order columns = #( 'person' 'product' 'amount' ) ].
!
testProperties
	| order |

	order := Order new id: 1; person: 2; product: 3; amount: 10.

	self assert: [ order id = 1 ].
	self assert: [ order person = 2 ].
	self assert: [ order product = 3 ].
	self assert: [ order amount = 10 ].
!
testFromObject
	| object order |

	object := Object new
		atProperty: 'id' put: 1;
		atProperty: 'person' put: 2;
		atProperty: 'product' put: 3;
		atProperty: 'amount' put: 10.

	order := Order fromObject: object.

	self assert: [ order id = 1 ].
	self assert: [ order person = 2 ].
	self assert: [ order product = 3 ].
	self assert: [ order amount = 10 ].
!
