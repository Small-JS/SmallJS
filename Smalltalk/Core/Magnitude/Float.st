CLASS Float EXTENDS Number MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains a JS number."

CLASSMETHODS

fromJs: jsNumber
	INLINE 'if( jsNumber == null ) return stNil'.
	^ self basicNew js: INLINE 'Number( jsNumber )'.
!

"Constants."

pi
	^ Float fromJs: INLINE 'Math.PI'.
!
epsilon
	^ Float fromJs: INLINE 'Number.EPSILON'.
!
random
	^ Float fromJs: INLINE 'Math.random()'.
!

METHODS

"Conversion."

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
toInteger
	INLINE
		'if( Number.isSafeInteger( Math.floor( this.js ) ) )
			return stInteger$class.$fromJs$( this.js );
		return stBigInt$class.$fromJs$( BigInt( this.js ) )'.
!
toFixed: decimals
	^ String fromJs: INLINE 'this.js.toFixed( decimals.js )'.
!

"Testing."

isSafeInteger
	^ Boolean fromJs: INLINE 'Number.isSafeInteger( this.js )'.
!

"Comparisons with number subsclass arguments.
 Delegate to float methods of argument."

= number
	^ number argIsEqualToFloat: self.
!
< number
	^ number argIsSmallerThanFloat: self.
!
<= number
	^ number argIsSmallerOrEqualToFloat: self.
!
equals: float precision: precision
	^ Boolean fromJs: INLINE 'Math.abs( this.js - float.js ) < precision.js'.
!

"Comparisons with integer arguments."

argIsEqualToInteger: integer
	^ Boolean fromJs: INLINE 'Math.abs( integer.js - this.js ) < Number.EPSILON'.
!
argIsSmallerThanInteger: integer
	^ Boolean fromJs: INLINE 'integer.js < this.js'.
!
argIsSmallerOrEqualToInteger: integer
	^ Boolean fromJs: INLINE 'integer.js <= this.js'.
!

"Comparisons with large integer arguments."

argIsEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'Math.abs( Number( bigInt.js ) - this.js ) < Number.EPSILON'.
!
argIsSmallerThanBigInt: bigInt
	^ Boolean fromJs: INLINE 'Number( bigInt.js ) < this.js'.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'Number( bigInt.js ) <= this.js'.
!

"Comparisons with fraction arguments."

argIsEqualToFraction: fraction
	^ fraction toFloat = self.
!
argIsSmallerThanFraction: fraction
	^ fraction toFloat < self.
!
argIsSmallerOrEqualToFraction: fraction
	^ fraction toFloat <= self.
!

"Comparisons with float arguments."

argIsEqualToFloat: float
	"Complate floats with standard epsilon precision.
	 NOTE: Epsilon may be to small in some cases. Then use equals:precision:"
	^ Boolean fromJs: INLINE 'Math.abs( float.js - this.js ) < Number.EPSILON'.
!
argIsSmallerThanFloat: float
	^ Boolean fromJs: INLINE 'float.js < this.js'.
!
argIsSmallerOrEqualToFloat: float
	^ Boolean fromJs: INLINE 'float.js <= this.js'.
!

"Basic math with numbers.
 Delegates to float handling methods of argument."

+ number
	^ number addToFloat: self.
!
- number
	^ number subtractFromFloat: self.
!
* number
	^ number multiplyByFloat: self.
!
/ number
	^ number divideIntoFloat: self.
!
// number
	^ number integerDivideIntoFloat: self.
!
% number
	^ number moduloFromFloat: self.
!

"Basic arithmatic with integers."

addToInteger: integer
	^ Float fromJs: INLINE 'integer.js + this.js'.
!
subtractFromInteger: integer
	^ Float fromJs: INLINE 'integer.js - this.js'.
!
multiplyByInteger: integer
	^ Float fromJs: INLINE 'integer.js * this.js'.
!
divideIntoInteger: integer
	^ Float fromJs: INLINE 'integer.js / this.js'.
!
integerDivideIntoInteger: integer
	^ Float fromJs: INLINE 'Math.trunc( integer.js / this.js )'.
!
moduloFromInteger: integer
	^ Float fromJs: INLINE 'integer.js % this.js'.
!

"Basic arithmatic with large integers."

addToBigInt: bigInt
	^ Float fromJs: INLINE 'Number( bigInt.js ) + this.js'.
!
subtractFromBigInt: bigInt
	^ Float fromJs: INLINE 'Number( bigInt.js ) - this.js'.
!
multiplyByBigInt: bigInt
	^ Float fromJs: INLINE 'Number( bigInt.js ) * this.js'.
!
divideIntoBigInt: bigInt
	^ Float fromJs: INLINE 'Number( bigInt.js ) / this.js'.
!
integerDivideIntoBigInt: bigInt
	^ Float fromJs: INLINE 'Math.trunc( Number( bigInt.js ) / this.js )'.
!
moduloFromBigInt: bigInt
	^ Float fromJs: INLINE 'Number( bigInt.js ) % this.js'.
!

"Basic arithmatic with floats."

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
	^ Float fromJs: INLINE 'Math.trunc( float.js / this.js )'.
!
moduloFromFloat: float
	^ Float fromJs: INLINE 'float.js % this.js'.
!

"Basic arithmatic with points
 is implementend in superclass Number."

"Other float artithmatic."

sqrt
	^ Float fromJs: INLINE 'Math.sqrt( this.js )'.
!
ln
	^ Float fromJs: INLINE 'Math.log( this.js )'.
!
log
	^ Float fromJs: INLINE 'Math.log( this.js ) / Math.log( 10 )'.
!
exp
	^ Float fromJs: INLINE 'Math.exp( this.js )'.
!
** power
	^ Float fromJs: INLINE 'Math.pow( this.js, power.js )'.
!
sin
	^ Float fromJs: INLINE 'Math.sin( this.js )'.
!
cos
	^ Float fromJs: INLINE 'Math.cos( this.js )'.
!
tan
	^ Float fromJs: INLINE 'Math.tan( this.js )'.
!
