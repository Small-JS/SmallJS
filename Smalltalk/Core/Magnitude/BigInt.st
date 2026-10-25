CLASS BigInt EXTENDS AbstractInteger MODULE Core CLASSVARS '' VARS ''
	"Inherited instance variable js contains a JS BigInt."

CLASSMETHODS

fromJs: jsBigInt
	INLINE 'if( jsBigInt == null ) return stNil$'.
	^ self basicNew js: INLINE 'BigInt( jsBigInt )'.
!

METHODS

"Conversion"

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
toFloat
	^ Float fromJs: INLINE 'Number( this.js )'.
!

"Comparisons with number subsclass arguments.
 Delegate to BigInt methods of argument."

= number
	^ number argIsEqualToBigInt: self.
!
< number
	^ number argIsSmallerThanBigInt: self.
!
<= number
	^ number argIsSmallerOrEqualToBigInt: self.
!

"Comparisons with Integer arguments."

argIsEqualToInteger: integer
	^ Boolean fromJs: INLINE 'BigInt( integer.js ) == this.js'.
!
argIsSmallerThanInteger: integer
	^ Boolean fromJs: INLINE 'BigInt( integer.js ) < this.js'.
!
argIsSmallerOrEqualToInteger: integer
	^ Boolean fromJs: INLINE 'BigInt( integer.js ) <= this.js'.
!

"Comparisons with BigInt arguments."

argIsEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js == this.js'.
!
argIsSmallerThanBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js < this.js'.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js <= this.js'.
!

"Comparisons with Float arguments."

argIsEqualToFloat: float
	^ Boolean fromJs: INLINE 'float.js == this.js'.
!
argIsSmallerThanFloat: float
	^ Boolean fromJs: INLINE 'float.js < this.js'.
!
argIsSmallerOrEqualToFloat: float
	^ Boolean fromJs: INLINE 'float.js <= this.js'.
!

"Comparions with fractions is implemented in superclass AbstractInteger."

"Basic arithmatic with number subsclass arguments.
 Delegates to large integer handling methods of argument."

+ number
	^ number addToBigInt: self.
!
- number
	^ number subtractFromBigInt: self.
!
* number
	^ number multiplyByBigInt: self.
!
/ number
	^ number divideIntoBigInt: self.
!
// number
	^ number integerDivideIntoBigInt: self.
!
% number
	^ number moduloFromBigInt: self.
!
** number
	^ number powerBaseBigInt: self.
!

"Basic arithmatic with Integer arguments."

addToInteger: integer
	^ BigInt fromJs: INLINE 'BigInt( integer.js ) + this.js'.
!
subtractFromInteger: integer
	^ BigInt fromJs: INLINE 'BigInt( integer.js ) - this.js'.
!
multiplyByInteger: integer
	^ BigInt fromJs: INLINE 'BigInt( integer.js ) * this.js'.
!
divideIntoInteger: integer
	^ Fraction numerator: integer denominator: self.
!
integerDivideIntoInteger: integer
	"Rounds down (floored division), consistent with moduloFromInteger:."
	INLINE '
		let a = BigInt( integer.js ), b = this.js;
		if( b != 0n ) {
			let q = a / b;
			if( a % b != 0n && ( a < 0n ) != ( b < 0n ) )
				q--;
			return stBigInt$class.$fromJs$( q ) }'.
	self divisionByZeroError.
!
moduloFromInteger: integer
	"Floored modulo: the result has the sign of the divisor (self)."
	INLINE '
		let a = BigInt( integer.js ), b = this.js;
		if( b != 0n ) {
			let r = a % b;
			if( r != 0n && ( r < 0n ) != ( b < 0n ) )
				r += b;
			return stBigInt$class.$fromJs$( r ) }'.
	self divisionByZeroError.
!
powerBaseInteger: integer
	self < 0 ifTrue: [ ^ 1 / ( integer ** self negated ) ].
	^ BigInt fromJs: INLINE 'BigInt( integer.js ) ** this.js'.
!

"Basic arithmatic with BigInt arguments."

addToBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js + this.js'.
!
subtractFromBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js - this.js'.
!
multiplyByBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js * this.js'.
!
divideIntoBigInt: bigInt
	^ Fraction numerator: bigInt denominator: self.
!
integerDivideIntoBigInt: bigInt
	"Rounds down (floored division), consistent with moduloFromBigInt:."
	INLINE '
		let a = bigInt.js, b = this.js;
		if( b != 0n ) {
			let q = a / b;
			if( a % b != 0n && ( a < 0n ) != ( b < 0n ) )
				q--;
			return stBigInt$class.$fromJs$( q ) }'.
	self divisionByZeroError.
!
moduloFromBigInt: bigInt
	"Floored modulo: the result has the sign of the divisor (self)."
	INLINE '
		let a = bigInt.js, b = this.js;
		if( b != 0n ) {
			let r = a % b;
			if( r != 0n && ( r < 0n ) != ( b < 0n ) )
				r += b;
			return stBigInt$class.$fromJs$( r ) }'.
	self divisionByZeroError.
!
powerBaseBigInt: bigInt
	self < 0 ifTrue: [ ^ 1 / ( bigInt ** self negated ) ].
	^ BigInt fromJs: INLINE 'bigInt.js ** this.js'.
!

"Basic arithmatic with fraction arguments
 is implemented in superclass AbstractInteger."

"Basic arithmatic with Float arguments."

addToFloat: float
	^ Float fromJs: INLINE 'float.js + Number( this.js )'.
!
subtractFromFloat: float
	^ Float fromJs: INLINE 'float.js - Number( this.js )'.
!
multiplyByFloat: float
	^ Float fromJs: INLINE 'float.js * Number( this.js )'.
!
divideIntoFloat: float
	^ Float fromJs: INLINE 'float.js / Number( this.js )'.
!
integerDivideIntoFloat: float
	^ Float fromJs: INLINE 'Math.floor( float.js / Number( this.js ) )'.
!
moduloFromFloat: float
	"Floored modulo: the result has the sign of the divisor (self)."
	INLINE '
		let b = Number( this.js );
		let r = float.js % b;
		if( r != 0 && ( r < 0 ) != ( b < 0 ) )
			r += b;
		return stFloat$class.$fromJs$( r )'.
!
powerBaseFloat: float
	^ Float fromJs: INLINE 'float.js ** Number( this.js )'.
!

"Bit operations."

& number
	^ BigInt fromJs: INLINE 'this.js & BigInt( number.js )'.
!
| number
	^ BigInt fromJs: INLINE 'this.js | BigInt( number.js )'.
!
xor: number
	^ BigInt fromJs: INLINE 'this.js ^ BigInt( number.js )'.
!
>> count
	^ BigInt fromJs: INLINE 'this.js >> BigInt( count.js )'.
!
<< count
	^ BigInt fromJs: INLINE 'this.js << BigInt( count.js )'.
!

"Basic arithmatic with points
 is implementend in superclass Number."

gcd: number
	"Answer greatest common denominator.
	 Implemented in JS for speed, because of use when normalizing fractions."

	^ BigInt fromJs: INLINE 'NumUtil.gcdBigInt( this.js, BigInt( number.js ) )'.
!
gcdInteger: integer
	^ self gcd: integer.
!
