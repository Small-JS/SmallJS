CLASS Float EXTENDS Number MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains a JS number."

CLASSMETHODS

fromJs: jsNumber
	INLINE 'if( jsNumber == null ) return stNil$'.
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
	"Truncates towards zero."
	INLINE
		'let jsTrunc = Math.trunc( this.js );
		if( Number.isSafeInteger( jsTrunc ) )
			return stInteger$class.$fromJs$( jsTrunc );
		if( Number.isFinite( jsTrunc ) )
			return stBigInt$class.$fromJs$( BigInt( jsTrunc ) )'.
	self error: 'Error: Cannot convert to integer: ', self toString.
!
toFixed: decimals
	^ String fromJs: INLINE 'this.js.toFixed( decimals.js )'.
!
f16Round
	^ Float fromJs: INLINE 'Math.f16round( this.js )'.
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

"Comparisons with Integer arguments."

argIsEqualToInteger: integer
	^ Boolean fromJs: INLINE 'Math.abs( integer.js - this.js ) < Number.EPSILON'.
!
argIsSmallerThanInteger: integer
	^ Boolean fromJs: INLINE 'integer.js < this.js'.
!
argIsSmallerOrEqualToInteger: integer
	^ Boolean fromJs: INLINE 'integer.js <= this.js'.
!

"Comparisons with BigInt arguments."

argIsEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'Math.abs( Number( bigInt.js ) - this.js ) < Number.EPSILON'.
!
argIsSmallerThanBigInt: bigInt
	^ Boolean fromJs: INLINE 'Number( bigInt.js ) < this.js'.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ Boolean fromJs: INLINE 'Number( bigInt.js ) <= this.js'.
!

"Comparisons with Fraction arguments."

argIsEqualToFraction: fraction
	^ fraction toFloat = self.
!
argIsSmallerThanFraction: fraction
	^ fraction toFloat < self.
!
argIsSmallerOrEqualToFraction: fraction
	^ fraction toFloat <= self.
!

"Comparisons with Float arguments."

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
** number
	^ number powerBaseFloat: self.
!

"Basic arithmatic with Integer arguments."

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
	"Truncates towards zero, consistent with moduloFromInteger:."
	^ Float fromJs: INLINE 'Math.trunc( integer.js / this.js )'.
!
moduloFromInteger: integer
	"JS modulo: the result has the sign of the dividend (integer)."
	^ Float fromJs: INLINE 'integer.js % this.js'.
!
powerBaseInteger: integer
	^ Float fromJs: INLINE 'integer.js ** this.js'.
!

"Basic arithmatic with BigInt arguments."

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
	"Truncates towards zero, consistent with moduloFromBigInt:."
	^ Float fromJs: INLINE 'Math.trunc( Number( bigInt.js ) / this.js )'.
!
moduloFromBigInt: bigInt
	"JS modulo: the result has the sign of the dividend (bigInt)."
	^ Float fromJs: INLINE 'Number( bigInt.js ) % this.js'.
!
powerBaseBigInt: bigInt
	^ Float fromJs: INLINE 'Number( bigInt.js ) ** this.js'.
!

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
sin
	^ Float fromJs: INLINE 'Math.sin( this.js )'.
!
cos
	^ Float fromJs: INLINE 'Math.cos( this.js )'.
!
tan
	^ Float fromJs: INLINE 'Math.tan( this.js )'.
!
