CLASS BigInt EXTENDS AbstractInteger MODULE Core CLASSVARS '' VARS ''
	"Inherited instance variable js contains a JS BigInt."

CLASSMETHODS

fromJs: jsBigInt
	INLINE 'if( jsBigInt == null ) return stNil'.
	^ self basicNew js: INLINE 'BigInt( jsBigInt )'.
!

METHODS

"Conversions."

toString
	^ String fromJs: js.
!
toFloat
	^ Float fromJs: INLINE 'Number( this.js )'.
!

"Comparisons with number subsclass arguments.
 Delegate to large integer methods of argument."

= number
	^ number argIsEqualToBigInt: self.
!
< number
	^ number argIsSmallerThanBigInt: self.
!
<= number
	^ number argIsSmallerOrEqualToBigInt: self.
!

"Comparisons with integer arguments."

argIsEqualToInteger: integer
	^ Boolean fromJs: INLINE 'BigInt( integer.js ) == this.js'.
!
argIsSmallerThanInteger: integer
	^ Boolean fromJs: INLINE 'BigInt( integer.js ) < this.js'.
!
argIsSmallerOrEqualToInteger: integer
	^ Boolean fromJs: INLINE 'BigInt( integer.js ) <= this.js'.
!

"Comparisons with large integer arguments."

argIsEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js == this.js'.
!
argIsSmallerThanBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js < this.js'.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'bigInt.js <= this.js'.
!

"Comparisons with float arguments."

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

"Basic arithmatic with integer arguments."

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
	^ BigInt fromJs: INLINE 'BigInt( integer.js ) / this.js'.
!
moduloFromInteger: integer
	^ BigInt fromJs: INLINE 'BigInt( integer.js ) % this.js'.
!

"Basic arithmatic with large integer arguments."

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
	^ BigInt fromJs: INLINE 'bigInt.js / this.js'.
!
moduloFromBigInt: bigInt
	^ BigInt fromJs: INLINE 'bigInt.js % this.js'.
!

"Basic arithmatic with fraction arguments
 is implemented in superclass AbstractInteger."

"Basic arithmatic with float arguments."

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
	^ Float fromJs: INLINE 'float.js % Number( this.js )'.
!

"Bit operations."

& number
	^ BigInt fromJs: INLINE 'this.js & number.js'.
!
| number
	^ BigInt fromJs: INLINE 'this.js | number.js'.
!
xor: number
	^ BigInt fromJs: INLINE 'this.js ^ number.js'.
!
>> count
	^ BigInt fromJs: INLINE 'this.js >> count.js'.
!
<< count
	^ BigInt fromJs: INLINE 'this.js << count.js'.
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
