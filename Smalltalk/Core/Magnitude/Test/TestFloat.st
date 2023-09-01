CLASS TestFloat EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testConstants
	self assert: [ Float pi toString startsWith: '3.14' ].
	self assert: [ Float epsilon < 0.000000001 ].
!
testConversion
	self assert: [ 3.4 toInteger = 3 ].
	self assert: [ 9007199254740991.0 isSafeInteger ].
	self assert: [ 9007199254740992.0 isSafeInteger not ].

!
testComparisons
	| bigInt fraction |

	self assert: [ 3.0 = 3.0 ].
	self assert: [ 7.0 <= 7.0 ].
	self assert: [ 7.0 >= 7.0 ].
	self assert: [ 2.9999999 equals: 3.0 precision: 0.00001 ].
	self assert: [ 2.9999999 < 3.0 ].
	self assert: [ 3.01 > 3.0 ].

	"Compare to integers."
	self assert: [ 3.0 = 3 ].
	self assert: [ 3.0 <= 3 ].
	self assert: [ 3.0 >= 3 ].
	self assert: [ 2.9 < 3 ].
	self assert: [ 3.1 > 3 ].

	"Compare to large integers."
	bigInt := BigInt fromJs: INLINE '13n'.
	self assert: [ bigInt class = BigInt ].
	self assert: [ 13.0 = bigInt ].
	self assert: [ 13.0 <= bigInt ].
	self assert: [ 13.0 >= bigInt ].
	self assert: [ 12.9 < bigInt ].
	self assert: [ 13.1 > bigInt ].

	"Compare to fractions."
	fraction := 1 / 2.
	self assert: [ fraction class = Fraction ].
	self assert: [ 0.5 = fraction ].
	self assert: [ 0.5 <= fraction ].
	self assert: [ 0.5 >= fraction ].
	self assert: [ 0.499 < fraction ].
	self assert: [ 0.501 > fraction ].
!
testBasicMath
	| bigInt fraction point |

	self assert: [ 2.0 + 3.0 = 5.0 ].
	self assert: [ 2.1 - 3.0 = -0.9 ].
	self assert: [ 4.1 * 3.0 - 12.3 < Float epsilon ].
	self assert: [ 7.0 / 2.0 = 3.5 ].
	self assert: [ 7.0 // 2.0 = 3.0 ].
	self assert: [ 7.0 % 2.0 = 1.0 ].

	"Basic math with integers."
	self assert: [ 2.0 + 3 = 5.0 ].
	self assert: [ 2.1 - 3 = -0.9 ].
	self assert: [ 4.1 * 3 - 12.3 < Float epsilon ].
	self assert: [ 7.0 / 2 = 3.5 ].
	self assert: [ 7.0 // 2 = 3.0 ].
	self assert: [ 7.0 % 2 = 1.0 ].

	"Basic math with large integers."
	bigInt := BigInt fromJs: INLINE '3n'.
	self assert: [ bigInt class = BigInt ].
	self assert: [ 2.0 + bigInt = 5.0 ].
	self assert: [ 2.1 - bigInt = -0.9 ].
	self assert: [ 4.1 * bigInt equals: 12.3 precision: 0.00001 ].
	bigInt := BigInt fromJs: INLINE '2n'.
	self assert: [ 7.0 / bigInt = 3.5 ].
	self assert: [ 7.0 // bigInt = 3.0 ].
	self assert: [ 7.0 % bigInt = 1.0 ].

	"Basic math with fractions."
	fraction := 1 / 2.
	self assert: [ fraction class = Fraction ].
	self assert: [ 1.0 + fraction = 1.5 ].
	self assert: [ -1.0 - fraction = -1.5 ].
	self assert: [ 4.2 * fraction = 2.1 ].
	self assert: [ 7.0 / fraction = 14.0 ].
	self assert: [ 7.1 // fraction = 14.0 ].
	self assert: [ 7.1 % fraction equals: 0.1 precision: 0.00001 ].

	"Basic math with points."
	point := 2.5 @ 3.0.
	self assert: [ point class = Point ].
	self assert: [ 1.0 + point = ( 3.5 @ 4.0 ) ].
	self assert: [ -1.0 - point = ( -3.5 @ -4.0 ) ].
	self assert: [ 2.0 * point = ( 5.0 @ 6.0 ) ].
	self assert: [ 30.0 / point = ( 12.0 @ 10.0 ) ].
	self assert: [ 5.0 // point = ( 2.0 @ 1.0 ) ].
	self assert: [ 5.0 % point = ( 0.0 @ 2.0 ) ].
!
testFunctions
	self assert: [ 2.0 sqrt equals: 1.4142135623730951 precision: 0.00001 ].
	self assert: [ 2.0 ln equals: 0.6931471805599453 precision: 0.00001 ].
	self assert: [ 2.0 log equals: 0.30102999566398114 precision: 0.00001 ].
	self assert: [ 2.0 exp equals: 7.38905609893065 precision: 0.00001 ].
	self assert: [ 2.0 ** 3 = 8.0 ].
	self assert: [ Float pi sin equals: 0.0 precision: 0.00001 ].
	self assert: [ Float pi cos equals: -1.0 precision: 0.00001 ].
	self assert: [ Float pi tan equals: 0.0 precision: 0.00001 ].
!
