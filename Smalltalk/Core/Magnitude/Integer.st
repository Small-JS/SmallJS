CLASS Integer EXTENDS AbstractInteger MODULE Core CLASSVARS '' VARS ''
	"Instance variable 'js' contains a JS number that should be an integer."

CLASSMETHODS

fromJs: jsNumber
	INLINE 'if( jsNumber == null ) return stNil'.
	^ self basicNew js: INLINE 'Number( Math.floor( jsNumber ) )'.
!

METHODS

"Conversions."

toString
	^ String fromJs: js.
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

"Comparisons with integer arguments."

argIsEqualToInteger: integer
	^ Boolean fromJs: INLINE 'integer.js == this.js'.
!
argIsSmallerThanInteger: integer
	^ Boolean fromJs: INLINE 'integer.js < this.js'.
!
argIsSmallerOrEqualToInteger: integer
	^ Boolean fromJs: INLINE 'integer.js <= this.js'.
!

"Comparisons with large integer arguments."

argIsEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js == BigInt( this.js )'.
!
argIsSmallerThanBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js < BigInt( this.js )'.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js <= BigInt( this.js )'.
!

"Comparisons with fractions
 are implementend in superclass AbstractInteger."

"Comparisons with float arguments."

argIsEqualToFloat: float
	^ Boolean fromJs: INLINE 'Math.abs( float.js - this.js ) < Number.EPSILON'.
!
argIsSmallerThanFloat: float
	^ Boolean fromJs: INLINE 'float.js < this.js'.
!
argIsSmallerOrEqualToFloat: float
	^ Boolean fromJs: INLINE 'float.js <= this.js'.
!

"Basic arithmatic with number subsclass arguments.
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

"Basic arithmatic with integer arguments."

addToInteger: integer
	INLINE '
		let jsResult = integer.js + this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt.$fromJs$( BigInt( integer.js ) + BigInt( this.js ) )'.
!
subtractFromInteger: integer
	INLINE '
		let jsResult = integer.js - this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt.$fromJs$( BigInt( integer.js ) - BigInt( this.js ) )'.
!
multiplyByInteger: integer
	INLINE '
		let jsResult = integer.js * this.js ;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt.$fromJs$( BigInt( integer.js ) * BigInt( this.js ) )'.
!
divideIntoInteger: integer
	INLINE '
		let jsResult = integer.js / this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult )'.
		^ Fraction numerator: integer denominator: self.
!
integerDivideIntoInteger: integer
	INLINE '
		let jsResult = Math.floor( integer.js / this.js );
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult )'.
	self divisionByZeroError.
!
moduloFromInteger: integer
	INLINE '
		let jsResult = integer.js % this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult )'.
	self divisionByZeroError.
!

"Basic arithmatic with large integer arguments."

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
		let modulo = bigInt.js % BigInt( this.js );
		if( modulo == 0 )
			return stBigInt$class.$fromJs$( bigInt.js / BigInt( this.js ) );'
	^ Fraction numerator: bigInt denominator: self.
!
integerDivideIntoBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js / BigInt( this.js )'.
!
moduloFromBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js % BigInt( this.js )'.
!

"Basic arithmatic with fractions
 is implementend in superclass AbstractInteger."

"Basic arithmatic with float arguments."

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
	^ Float fromJs: INLINE 'float.js % this.js'.
!

"Basic arithmatic with points
 is implementend in superclass Number."

"Bit operations."

& number
	^ Integer fromJs: INLINE 'this.js & number.js'.
!
| number
	^ Integer fromJs: INLINE 'this.js | number.js'.
!
xor: number
	^ Integer fromJs: INLINE 'this.js ^ number.js'.
!
>> count
	^ Integer fromJs: INLINE 'this.js >> count.js'.
!
<< count
	^ Integer fromJs: INLINE 'this.js << count.js'.
!

gcd: number
	"Answer greatest common denominator.
	 Implemented in JS for speed, because of use when normalizing fractions."

	^ number gcdInteger: self
!
gcdInteger: number
	"Private"
	^ Integer fromJs: INLINE 'NumUtil.gcd( this.js, number.js )'.
!
