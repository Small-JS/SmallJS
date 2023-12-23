CLASS TestProduct EXTENDS Test MODULE TestShopClient CLASSVARS '' VARS ''

testColumns
	self assert: [ Product columns = #( 'name' 'price' ) ].
!
testProperties
	| product |

	product := Product new id: 1; name: 'Apple'; price: 150.

	self assert: [ product id = 1 ].
	self assert: [ product name = 'Apple' ].
	self assert: [ product price = 150 ].
	self assert: [ product priceString = '1.50' ].
!
testFromObject
	| object product |

	object := Object new
		atProperty: 'id' put: 2;
		atProperty: 'name' put: 'Orange';
		atProperty: 'price' put: 175.

	product := Product fromObject: object.

	self assert: [ product id = 2 ].
	self assert: [ product name = 'Orange' ].
	self assert: [ product price = 175 ].
	self assert: [ product priceString = '1.75' ].
!
