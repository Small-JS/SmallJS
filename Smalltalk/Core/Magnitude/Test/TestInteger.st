CLASS TestInteger EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ 42 class = Integer ].
	self assert: [ ( Integer fromJs: INLINE '7' ) class = Integer ].
	self assert: [ #( 2 3 4 ) includes: ( Integer randomFrom: 2 to: 4 ) ].
!
testConversion
	self assert: [ 123 toString = '123' ].
	self assert: [ 123 toBigInt class = BigInt ].
	self assert: [ 8 toFloat = 8.0 ].
!
testComparisons
	self assert: [ 11 = 11 ].
	self assert: [ 11 <= 11 ].
	self assert: [ 11 >= 11 ].
	self assert: [ 11 < 12 ].
	self assert: [ 13 > 11 ].

	"Comparisons with large integer arguments."
	self assert: [ 11 = 11 toBigInt ].
	self assert: [ 11 <= 11 toBigInt ].
	self assert: [ 11 >= 11 toBigInt ].
	self assert: [ 11 < 12 toBigInt ].
	self assert: [ 13 > 11 toBigInt ].

	"Comparisons with fractions."
	self assert: [ 2 = ( 4 / 2 ) ].
	self assert: [ 2 >= ( 4 / 2 ) ].
	self assert: [ 2 <= ( 4 / 2 ) ].
	self assert: [ 2 < ( 7 / 3 ) ].
	self assert: [ 2 > ( 5 / 3 ) ].

	"Comparisons with floats."
	self assert: [ 2 = 2.0 ].
	self assert: [ 2 >= 2.0 ].
	self assert: [ 2 >= 2.0 ].
	self assert: [ 2 < 2.1 ].
	self assert: [ 2 > 1.95 ].
!
testBasicArithmatic
	self assert: [ 3 + 4 = 7 ].
	self assert: [ 4 - 3 = 1 ].
	self assert: [ 3 * 4 = 12 ].
	self assert: [ 4 / 3 = ( 4 / 3 ) ].
	self assert: [ 7 // 3 = 2 ].
	self assert: [ 7 % 3 = 1 ].

	"Basic arithmatic with large integer arguments."
	self assert: [ 3 + 4 toBigInt = 7 ].
	self assert: [ 4 - 3 toBigInt = 1 ].
	self assert: [ 3 * 4 toBigInt = 12 ].
	self assert: [ 4 / 3 toBigInt = ( 4 / 3 ) ].
	self assert: [ 7 // 3 toBigInt = 2 ].
	self assert: [ 7 % 3 toBigInt = 1 ].

	"Basic arithmatic with fractions."
	self assert: [ 3 + ( 1 / 2 ) = ( 7 / 2 ) ].
	self assert: [ 4 - ( 1 / 2 ) = ( 7 / 2 ) ].
	self assert: [ 4 * ( 1 / 2 ) = 2 ].
	self assert: [ 2 / ( 1 / 2 ) = 4 ].
	self assert: [ 3 // ( 2 / 3 ) = 4 ].
	self assert: [ 2 % ( 4 / 3 ) = ( 2 / 3 ) ].

	"Basic arithmatic with floats."
	self assert: [ 3 + 0.5 = 3.5 ].
	self assert: [ 4 - 0.5 = 3.5 ].
	self assert: [ 4 * 0.5 = 2.0 ].
	self assert: [ 2 / 0.5 = 4 ].
	self assert: [ 3 // 0.8 = 3.0 ].
	self assert: [ 2 % 0.8 = 0.4 ].

	"Basic arithmatic with points."
	self assert: [ 3 + ( 1 @ 2 ) = ( 4 @ 5 ) ].
	self assert: [ 4 - ( 1 @ 2 ) = ( 3 @ 2 ) ].
	self assert: [ 2 * ( 2 @ 3 ) = ( 4 @ 6 ) ].
	self assert: [ 6 / ( 2 @ 3 ) = ( 3 @ 2 ) ].
	self assert: [ 7 // ( 2 @ 3 ) = ( 3 @ 2 ) ].
	self assert: [ 8 % ( 2 @ 3 ) = ( 0 @ 2 ) ].
!
testBitOperations
	self assert: [ 6 & 3 = 2 ].
	self assert: [ 6 | 3 = 7 ].
	self assert: [ ( 6 xor: 3 ) = 5 ].
	self assert: [ 7 >> 1 = 3 ].
	self assert: [ 3 << 1 = 6 ].

!
testGcd
	self assert: [ ( 12 gcd: 9 ) = 3 ].
	self assert: [ ( 12 gcd: 9 toBigInt ) = 3 ].
!
