CLASS TestBigInt EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ 9007199254740992 class = BigInt ].
	self assert: [ 13 toBigInt class = BigInt ].
!
testConversion
	self assert: [ 13 toBigInt toString = '13' ].
	self assert: [ 13 toBigInt toFloat = 13.0 ].
!
testComparisons
	self assert: [ 11 toBigInt = 11 toBigInt ].
	self assert: [ 11 toBigInt <= 11 toBigInt ].
	self assert: [ 11 toBigInt >= 11 toBigInt ].
	self assert: [ 11 toBigInt < 13 toBigInt ].
	self assert: [ 13 toBigInt > 11 toBigInt ].

	"Comparisons with integer arguments."
	self assert: [ 11 toBigInt = 11 ].
	self assert: [ 11 toBigInt <= 11 ].
	self assert: [ 11 toBigInt >= 11 ].
	self assert: [ 11 toBigInt < 12 ].
	self assert: [ 13 toBigInt > 12 ].

	"Comparisons with float arguments."
	self assert: [ 11 toBigInt = 11.0 ].
	self assert: [ 11 toBigInt <= 11.0 ].
	self assert: [ 11 toBigInt >= 11.0 ].
	self assert: [ 11 toBigInt < 12.0 ].
	self assert: [ 13 toBigInt > 12.0 ].

	"Comparions with fractions."
	self assert: [ 11 toBigInt = ( 22 / 2 ) ].
	self assert: [ 11 toBigInt <= ( 23 / 2 ) ].
	self assert: [ 11 toBigInt >= ( 21 / 2 ) ].
	self assert: [ 11 toBigInt < ( 23 / 2 ) ].
	self assert: [ 13 toBigInt > ( 25 / 2 ) ].
!
testBasicArithmatic
	self assert: [ 3 toBigInt + 4 toBigInt = 7 toBigInt ].
	self assert: [ 4 toBigInt - 3 toBigInt = 1 toBigInt ].
	self assert: [ 3 toBigInt * 4 toBigInt = 12 toBigInt ].
	self assert: [ 4 toBigInt / 3 toBigInt = ( 4 / 3 ) ].
	self assert: [ 7 toBigInt // 3 toBigInt = 2 toBigInt ].
	self assert: [ 7 toBigInt % 3 toBigInt = 1 toBigInt ].

	"Basic arithmatic with integer arguments."
	self assert: [ 3 toBigInt + 10 = 13 ].
	self assert: [ 3 toBigInt - 5 = -2 ].
	self assert: [ 3 toBigInt * 2 = 6 ].
	self assert: [ 3 toBigInt / 4 = ( 3 / 4 ) ].
	self assert: [ 7 toBigInt // 3 = 2 ].
	self assert: [ 7 toBigInt % 3 = 1 ].

	"Basic arithmatic with fraction arguments."
	self assert: [ 3 toBigInt + ( 1 / 2 ) = ( 7 / 2 ) ].
	self assert: [ 4 toBigInt - ( 1 / 2 ) = ( 7 / 2 ) ].
	self assert: [ 4 toBigInt * ( 1 / 2 ) = 2 ].
	self assert: [ 2 toBigInt / ( 1 / 2 ) = 4 ].
	self assert: [ 3 toBigInt // ( 2 / 3 ) = 4 ].
	self assert: [ 2 toBigInt % ( 4 / 3 ) = ( 2 / 3 ) ].

	"Basic arithmatic with float arguments."
	self assert: [ 3 toBigInt + 10.0 = 13.0 ].
	self assert: [ 3 toBigInt - 5.0 = -2.0 ].
	self assert: [ 3 toBigInt * 2.0 = 6.0 ].
	self assert: [ 3 toBigInt / 4.0 = 0.75 ].
	self assert: [ 7 toBigInt // 3.0 = 2.0 ].
	self assert: [ 7 toBigInt % 3.0 = 1.0 ].

	"Basic arithmatic with points."
	self assert: [ 3 toBigInt + ( 1 @ 2 ) = ( 4 @ 5 ) ].
	self assert: [ 4 toBigInt - ( 1 @ 2 ) = ( 3 @ 2 ) ].
	self assert: [ 2 toBigInt * ( 2 @ 3 ) = ( 4 @ 6 ) ].
	self assert: [ 6 toBigInt / ( 2 @ 3 ) = ( 3 @ 2 ) ].
	self assert: [ 7 toBigInt // ( 2 @ 3 ) = ( 3 @ 2 ) ].
	self assert: [ 8 toBigInt % ( 2 @ 3 ) = ( 0 @ 2 ) ].
!
testBitOperations
	self assert: [ 6 toBigInt & 3 toBigInt = 2 ].
	self assert: [ 6 toBigInt | 3 toBigInt = 7 ].
	self assert: [ ( 6 toBigInt xor: 3 toBigInt ) = 5 ].
	self assert: [ 7 toBigInt >> 1 toBigInt = 3 ].
	self assert: [ 3 toBigInt << 1 toBigInt = 6 ].

!
testGcd
	self assert: [ ( 12 toBigInt gcd: 9 toBigInt ) = 3 ].
	self assert: [ ( 12 toBigInt gcd: 9 ) = 3 ].
!
