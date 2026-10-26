CLASS Integer EXTENDS AbstractInteger MODULE Core CLASSVARS '' VARS ''
	"Instance variable 'js' contains a JS number that should be an integer."

CLASSMETHODS

fromJs: jsNumber
	INLINE 'if( jsNumber == null ) return stNil$'.
	^ self basicNew js: INLINE 'Number( Math.trunc( jsNumber ) )'.
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
	"Truncates towards zero, consistent with moduloFromInteger:."
	INLINE '
		if( this.js != 0 )
			return stInteger$class.$fromJs$( Math.trunc( integer.js / this.js ) )'.
	self divisionByZeroError.
!
moduloFromInteger: integer
	"JS modulo: the result has the sign of the dividend (integer)."
	INLINE '
		if( this.js != 0 )
			return stInteger$class.$fromJs$( integer.js % this.js )'.
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
	"Truncates towards zero, consistent with moduloFromBigInt:."
	INLINE '
		if( this.js != 0 )
			return stBigInt$class.$fromJs$( bigInt.js / BigInt( this.js ) )'.
	self divisionByZeroError.
!
moduloFromBigInt: bigInt
	"JS modulo: the result has the sign of the dividend (bigInt)."
	INLINE '
		if( this.js != 0 )
			return stBigInt$class.$fromJs$( bigInt.js % BigInt( this.js ) )'.
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
	"Truncates towards zero, consistent with moduloFromFloat:."
	^ Float fromJs: INLINE 'Math.trunc( float.js / this.js )'.
!
moduloFromFloat: float
	"JS modulo: the result has the sign of the dividend (float)."
	^ Float fromJs: INLINE 'float.js % this.js'.
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

