CLASS TestFraction EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ ( Fraction numerator: 2 denominator: 3 ) = ( 2 / 3 ) ].
	self assert: [ ( Fraction numerator: 4 denominator: 6 ) = ( 2 / 3 ) ].
!
testConversion
	self assert: [ ( 5 / 3 ) toInteger = 1 ].
	self assert: [ ( 3 / 4 ) toFloat = 0.75 ].
	self assert: [ ( 3 / 4 ) toString = '( 3 / 4 )' ].

!
testAccessing
	self assert: [ ( Fraction numerator: 2 denominator: 3 ) numerator = 2 ].
	self assert: [ ( Fraction numerator: 2 denominator: 3 ) denominator = 3 ].
!
testComparisons
	| bigInt fraction |

	self assert: [ ( 2 / 3 ) = ( 4 / 6 ) ].
	self assert: [ ( 2 / 3 ) <= ( 2 / 3 ) ].
	self assert: [ ( 2 / 3 ) >= ( 2 / 3 ) ].
	self assert: [ ( 2 / 3 ) < ( 5 / 6 ) ].
	self assert: [ ( 2 / 3 ) > ( 3 / 6 ) ].

	"Compare to integers."
	self assert: [ ( 4 / 2 ) = 2 ].
	self assert: [ ( 4 / 2 ) <= 2 ].
	self assert: [ ( 4 / 2 ) >= 2 ].
	self assert: [ ( 7 / 3 ) < 3 ].
	self assert: [ ( 7 / 3 ) > 2 ].

	"Compare to large integers."
	bigInt := BigInt fromJs: INLINE '2n'.
	self assert: [ ( 4 / 2 ) = bigInt ].
	self assert: [ ( 4 / 2 ) <= bigInt ].
	self assert: [ ( 4 / 2 ) >= bigInt ].
	self assert: [ ( 5 / 3 ) < bigInt ].
	self assert: [ ( 7 / 3 ) > bigInt ].

!
testBasicMath
	| bigInt point |

	self assert: [ ( 1 / 3 ) + ( 1 / 6 ) = ( 1 / 2 ) ].
	self assert: [ ( 1 / 3 ) - ( 1 / 6 ) = ( 1 / 6 ) ].
	self assert: [ ( 1 / 3 ) * ( 2 / 3 ) = ( 2 / 9 ) ].
	self assert: [ ( 1 / 3 ) / ( 2 / 3 ) = ( 1 / 2 ) ].
	self assert: [ ( 7 / 3 ) // ( 1 / 2 ) = 4 ].
	self assert: [ ( 7 / 3 ) % ( 1 / 2 ) = ( 1 / 3 ) ].

	"Basic math with integers."
	self assert: [ ( 2 / 3 ) + 2 = ( 8 / 3 ) ].
	self assert: [ ( 4 / 3 ) - 1 = ( 1 / 3 ) ].
	self assert: [ ( 4 / 3 ) * 2 = ( 8 / 3 ) ].
	self assert: [ ( 4 / 3 ) / 2 = ( 2 / 3 ) ].
	self assert: [ ( 8 / 3 ) // 2 = 1 ].
	self assert: [ ( 8 / 3 ) % 2 = ( 2 / 3 ) ].

	"Basic math with points."
	self assert: [ ( 1 / 3 ) + ( 2 @ 3 ) = ( ( 7 / 3 ) @ ( 10 / 3 ) ) ].
	self assert: [ ( 1 / 3 ) - ( 1 @ 2 ) = ( ( -2 / 3 ) @ ( -5 / 3 ) ) ].
	self assert: [ ( 1 / 3 ) * ( 1 @ 2 ) = ( ( 1 / 3 ) @ ( 2 / 3 ) ) ].
	self assert: [ ( 1 / 3 ) / ( 1 @ 2 ) = ( ( 1 / 3 ) @ ( 1 / 6 ) ) ].
	self assert: [ ( 1 / 3 ) // ( 1 @ 2 ) = ( 0 @ 0 ) ].
	self assert: [ ( 1 / 3 ) % ( 1 @ 2 ) = ( ( 1 / 3 ) @ ( 1 / 3 ) ) ].
!
testFunctions
	self assert: [ ( 1 / 3 ) negated = ( -1 / 3 ) ].
!
