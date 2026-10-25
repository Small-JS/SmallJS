CLASS Integer EXTENDS AbstractInteger MODULE Core CLASSVARS '' VARS ''
	"Instance variable 'js' contains a JS number that should be an integer."

CLASSMETHODS

fromJs: jsNumber
	INLINE 'if( jsNumber == null ) return stNil$'.
	^ self basicNew js: INLINE 'Number( Math.floor( jsNumber ) )'.
!
randomFrom: min to: max
	^ ( Float random * ( max - min + 1 ) + min ) toInteger.
!

METHODS

"Conversions."

toString
	^ String fromJs: INLINE 'String( this.js )'.
!
toBigInt
	^ BigInt fromJs: js.
!
toFloat
	^ Float fromJs: js.
!

"Comparisons with number subsclass arguments.
 Delegate to integer handling methods of argument."

= number
	^ number argIsEqualToInteger: self.
!
< number
	^ number argIsSmallerThanInteger: self.
!
<= number
	^ number argIsSmallerOrEqualToInteger: self.
!

"Comparisons with Integer arguments."

argIsEqualToInteger: integer
	^ Boolean fromJs: INLINE 'integer.js == this.js'.
!
argIsSmallerThanInteger: integer
	^ Boolean fromJs: INLINE 'integer.js < this.js'.
!
argIsSmallerOrEqualToInteger: integer
	^ Boolean fromJs: INLINE 'integer.js <= this.js'.
!

"Comparisons with BigInt arguments."

argIsEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js == BigInt( this.js )'.
!
argIsSmallerThanBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js < BigInt( this.js )'.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js <= BigInt( this.js )'.
!

"Comparisons with Fraction arguments
 are implementend in superclass AbstractInteger."

"Comparisons with Float arguments."

argIsEqualToFloat: float
	^ Boolean fromJs: INLINE 'Math.abs( float.js - this.js ) < Number.EPSILON'.
!
argIsSmallerThanFloat: float
	^ Boolean fromJs: INLINE 'float.js < this.js'.
!
argIsSmallerOrEqualToFloat: float
	^ Boolean fromJs: INLINE 'float.js <= this.js'.
!

"Basic arithmatic with Number subsclass arguments.
 Delegate to integer methods of argument."

+ number
	^ number addToInteger: self.
!
- number
	^ number subtractFromInteger: self.
!
* number
	^ number multiplyByInteger: self.
!
/ number
	^ number divideIntoInteger: self.
!
// number
	^ number integerDivideIntoInteger: self.
!
% number
	^ number moduloFromInteger: self.
!
** number
	^ number powerBaseInteger: self.
!

"Basic arithmatic with Integer arguments."

addToInteger: integer
	INLINE '
		let jsResult = integer.js + this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) + BigInt( this.js ) )'.
!
subtractFromInteger: integer
	INLINE '
		let jsResult = integer.js - this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) - BigInt( this.js ) )'.
!
multiplyByInteger: integer
	INLINE '
		let jsResult = integer.js * this.js ;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) * BigInt( this.js ) )'.
!
divideIntoInteger: integer
	INLINE '
		let jsResult = integer.js / this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult )'.
		^ Fraction numerator: integer denominator: self.
!
integerDivideIntoInteger: integer
	"Rounds down (floored division), consistent with moduloFromInteger:."
	INLINE '
		let a = integer.js, b = this.js;
		if( b != 0 ) {
			let r = a % b;
			let q = ( a - r ) / b;
			if( r != 0 && ( r < 0 ) != ( b < 0 ) )
				q--;
			return stInteger$class.$fromJs$( q ) }'.
	self divisionByZeroError.
!
moduloFromInteger: integer
	"Floored modulo: the result has the sign of the divisor (self)."
	INLINE '
		let a = integer.js, b = this.js;
		if( b != 0 ) {
			let r = a % b;
			if( r != 0 && ( r < 0 ) != ( b < 0 ) )
				r += b;
			return stInteger$class.$fromJs$( r ) }'.
	self divisionByZeroError.
!
powerBaseInteger: integer
	self < 0 ifTrue: [ ^ 1 / ( integer ** self negated ) ].
	INLINE '
		let jsResult = integer.js ** this.js ;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) ** BigInt( this.js ) )'.
!

"Basic arithmatic with BigInt arguments."

addToBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js + BigInt( this.js )'.
!
subtractFromBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js - BigInt( this.js )'.
!
multiplyByBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js * BigInt( this.js )'.
!
divideIntoBigInt: bigInt
	INLINE '
		if( this.js != 0 && bigInt.js % BigInt( this.js ) == 0n )
			return stBigInt$class.$fromJs$( bigInt.js / BigInt( this.js ) )'.
	^ Fraction numerator: bigInt denominator: self.
!
integerDivideIntoBigInt: bigInt
	"Rounds down (floored division), consistent with moduloFromBigInt:."
	INLINE '
		let a = bigInt.js, b = BigInt( this.js );
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
		let a = bigInt.js, b = BigInt( this.js );
		if( b != 0n ) {
			let r = a % b;
			if( r != 0n && ( r < 0n ) != ( b < 0n ) )
				r += b;
			return stBigInt$class.$fromJs$( r ) }'.
	self divisionByZeroError.
!
powerBaseBigInt: bigInt
	self < 0 ifTrue: [ ^ 1 / ( bigInt ** self negated ) ].
	^ BigInt fromJs: INLINE 'bigInt.js ** BigInt( this.js )'.
!

"Basic arithmatic with fractions
 is implementend in superclass AbstractInteger."

"Basic arithmatic with Float arguments."

addToFloat: float
	^ Float fromJs: INLINE 'float.js + this.js'.
!
subtractFromFloat: float
	^ Float fromJs: INLINE 'float.js - this.js'.
!
multiplyByFloat: float
	^ Float fromJs: INLINE 'float.js * this.js'.
!
divideIntoFloat: float
	^ Float fromJs: INLINE 'float.js / this.js'.
!
integerDivideIntoFloat: float
	^ Float fromJs: INLINE 'Math.floor( float.js / this.js )'.
!
moduloFromFloat: float
	"Floored modulo: the result has the sign of the divisor (self)."
	INLINE '
		let r = float.js % this.js;
		if( r != 0 && ( r < 0 ) != ( this.js < 0 ) )
			r += this.js;
		return stFloat$class.$fromJs$( r )'.
!
powerBaseFloat: float
	^ Float fromJs: INLINE 'float.js ** this.js'.
!

"Basic arithmatic with points
 is implementend in superclass Number."

"Bit operations.
 JS number bit operations work on 32 bits only,
 so operands outside that range are handled as BigInts."

& number
	INLINE '
		if( ( this.js | 0 ) === this.js && typeof number.js == "number" && ( number.js | 0 ) === number.js )
			return stInteger$class.$fromJs$( this.js & number.js );
		return this.$fromBigIntResult$( BigInt( this.js ) & BigInt( number.js ) )'.
!
| number
	INLINE '
		if( ( this.js | 0 ) === this.js && typeof number.js == "number" && ( number.js | 0 ) === number.js )
			return stInteger$class.$fromJs$( this.js | number.js );
		return this.$fromBigIntResult$( BigInt( this.js ) | BigInt( number.js ) )'.
!
xor: number
	INLINE '
		if( ( this.js | 0 ) === this.js && typeof number.js == "number" && ( number.js | 0 ) === number.js )
			return stInteger$class.$fromJs$( this.js ^ number.js );
		return this.$fromBigIntResult$( BigInt( this.js ) ^ BigInt( number.js ) )'.
!
>> count
	INLINE '
		if( ( this.js | 0 ) === this.js && typeof count.js == "number" && count.js >= 0 && count.js < 32 )
			return stInteger$class.$fromJs$( this.js >> count.js );
		return this.$fromBigIntResult$( BigInt( this.js ) >> BigInt( count.js ) )'.
!
<< count
	^ self fromBigIntResult: INLINE 'BigInt( this.js ) << BigInt( count.js )'.
!
fromBigIntResult: jsBigInt
	"Private. Answer an Integer if the JS BigInt fits in a safe integer, else a BigInt."
	INLINE '
		if( Number.isSafeInteger( Number( jsBigInt ) ) )
			return stInteger$class.$fromJs$( Number( jsBigInt ) );
		return stBigInt$class.$fromJs$( jsBigInt )'.
!

"gcd"

gcd: number
	"Answer greatest common denominator."
	^ number gcdInteger: self
!
gcdInteger: number
	"Private"
	^ Integer fromJs: INLINE 'NumUtil.gcd( this.js, number.js )'.
!

