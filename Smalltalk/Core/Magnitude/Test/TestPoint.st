CLASS TestPoint EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ ( Point x: 1 y: 2 ) = ( 1 @ 2 ) ].
	self assert: [ ( Point jsX: ( 1 js ) jsY: ( 2 js ) ) = ( 1 @ 2 ) ].
!
testConversion
	self assert: [ ( 1 @ 2 ) toString = '( 1 @ 2 )' ].
!
testAccessing
	self assert: [ ( Point x: 1 y: 2 ) x = 1 ].
	self assert: [ ( Point x: 1 y: 2 ) y = 2 ].

	self assert: [ ( ( 1 @ 2 ) x: 4 ) x = 4 ].
	self assert: [ ( ( 1 @ 2 ) y: 5 ) y = 5 ].

!
testComparisons
	self assert: [ ( 1 @ 2 ) = ( 1 @ 2 ) ].
	self assert: [ ( 1 @ 2 ) <= ( 1 @ 2 ) ].
	self assert: [ ( 1 @ 2 ) >= ( 1 @ 2 ) ].
	self assert: [ ( 1 @ 2 ) < ( 2 @ 3 ) ].
	self assert: [ ( 2 @ 3 ) > ( 1 @ 2 ) ].

!
testBasicArithmatic
	self assert: [ ( 1 @ 2 ) + ( 3 @ 4 ) = ( 4 @ 6 ) ].
	self assert: [ ( 3 @ 4 ) - ( 1 @ 2 ) = ( 2 @ 2 ) ].
	self assert: [ ( 1 @ 2 ) * ( 3 @ 4 ) = ( 3 @ 8 ) ].
	self assert: [ ( 4 @ 8 ) / ( 2 @ 4 ) = ( 2 @ 2 ) ].
	self assert: [ ( 4 @ 8 ) // ( 3 @ 5 ) = ( 1 @ 1 ) ].
	self assert: [ ( 4 @ 8 ) % ( 3 @ 5 ) = ( 1 @ 3 ) ].

	"Basic arithmatic with integer arguments."
	self assert: [ ( 1 @ 2 ) + 3 = ( 4 @ 5 ) ].
	self assert: [ ( 3 @ 4 ) - 2 = ( 1 @ 2 ) ].
	self assert: [ ( 1 @ 2 ) * 3 = ( 3 @ 6 ) ].
	self assert: [ ( 4 @ 8 ) / 2 = ( 2 @ 4 ) ].
	self assert: [ ( 4 @ 8 ) // 3 = ( 1 @ 2 ) ].
	self assert: [ ( 4 @ 8 ) % 3 = ( 1 @ 2 ) ].

	"Basic arithmatic with large integer arguments."
	self assert: [ ( 1 @ 2 ) + 3 toBigInt = ( 4 @ 5 ) ].
	self assert: [ ( 3 @ 4 ) - 2 toBigInt = ( 1 @ 2 ) ].
	self assert: [ ( 1 @ 2 ) * 3 toBigInt = ( 3 @ 6 ) ].
	self assert: [ ( 4 @ 8 ) / 2 toBigInt = ( 2 @ 4 ) ].
	self assert: [ ( 4 @ 8 ) // 3 toBigInt = ( 1 @ 2 ) ].
	self assert: [ ( 4 @ 8 ) % 3 toBigInt = ( 1 @ 2 ) ].

	"Basic arithmatic with float arguments."
	self assert: [ ( 1 @ 2 ) + 3.5 = ( 4.5 @ 5.5 ) ].
	self assert: [ ( 3 @ 4 ) - 2.5 = ( 0.5 @ 1.5 ) ].
	self assert: [ ( 1 @ 2 ) * 1.5 = ( 1.5 @ 3.0 ) ].
	self assert: [ ( 3 @ 7 ) / 2.0 = ( 1.5 @ 3.5 ) ].
	self assert: [ ( 4 @ 8 ) // 3.5 = ( 1.0 @ 2.0 ) ].
	self assert: [ ( 4 @ 8 ) % 3.5 = ( 0.5 @ 1.0 ) ].

	"Basic arithmatic with fraction arguments."
	self assert: [ ( 1 @ 2 ) + ( 1 / 2 ) = ( ( 3 / 2 ) @ ( 5 / 2 ) ) ].
	self assert: [ ( 3 @ 4 ) - ( 1 / 2 ) = ( ( 5 / 2 ) @ ( 7 / 2 ) ) ].
	self assert: [ ( 1 @ 2 ) * ( 1 / 2 ) = ( ( 1 / 2 ) @ 1 ) ].
	self assert: [ ( 3 @ 7 ) / ( 1 / 2 ) = ( 6 @ 14 ) ].
	self assert: [ ( 4 @ 8 ) // ( 4 / 3 ) = ( 3 @ 6 ) ].
	self assert: [ ( 1 @ 2 ) % ( 2 / 3 ) = ( ( 1 / 3 ) @ 0 ) ].

!
testFunctions
	self assert: [ ( 2 @ 3 ) negated = ( -2 @ -3 ) ].
	self assert: [ ( -2 @ -3 ) abs = ( 2 @ 3 ) ].
	self assert: [ ( ( 2 @ 3 ) dotProduct: ( 4 @ 5 ) ) = 23 ].

!
