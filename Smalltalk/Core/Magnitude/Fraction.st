CLASS Fraction EXTENDS Number MODULE Core CLASSVARS '' VARS 'numerator denominator'
	"Holds 2 ST integers, numerator and denominator, to represent a fraction.
	 The fraction is created with normalized coefficients,
	 reverting to integer if the denominator is 1."

CLASSMETHODS

numerator: numerator denominator: denominator
	^ self new numerator: numerator denominator: denominator.
!

METHODS

"Accessing."

numerator
	^ numerator.
!
denominator
	^ denominator.
!
numerator: aNumerator denominator: aDenominator
	numerator := aNumerator.
	denominator := aDenominator.
	^ self normalize.
!

"Creation.
 Fractions are normalized on creation.
 If the result of that is no longer a fraction (denominator = 1),
 the numerator integer is returned."

normalize
	"Normalize self."

	| gcd |

	denominator = 0 ifTrue: [
		self divisionByZeroError ].

	gcd := numerator gcd: denominator.
	gcd > 1 ifTrue: [
		numerator := numerator // gcd.
		denominator := denominator // gcd ].

	denominator < 0 ifTrue: [
		denominator := denominator negated.
		numerator := numerator negated ].

	denominator = 1 ifTrue: [
		^ numerator ].
!

"Conversion."

toString
	^ '( ', numerator toString, ' / ', denominator toString, ' )'.
!
toFloat
	^ numerator toFloat / denominator toFloat.
!
toInteger
	^ numerator toFloat // denominator toFloat.
!

"Comparisons with number subsclass arguments.
 Delegate to fraction methods of argument."

= number
	^ number argIsEqualToFraction: self.
!
< number
	^ number argIsSmallerThanFraction: self.
!
<= number
	^ number argIsSmallerOrEqualToFraction: self.
!

"Comparisons with integer arguments."

argIsEqualToInteger: integer
	^ integer * denominator = numerator.
!
argIsSmallerThanInteger: integer
	^ integer * denominator < numerator.
!
argIsSmallerOrEqualToInteger: integer
	^ integer * denominator <= numerator.
!

"Comparisons with large integer arguments."

argIsEqualToBigInt: bigInt
	^ bigInt * denominator = numerator.
!
argIsSmallerThanBigInt: bigInt
	^ bigInt * denominator < numerator.
!
argIsSmallerOrEqualToBigInt: bigInt
	^ bigInt * denominator <= numerator.
!

"Comparisons with fraction arguments."

argIsEqualToFraction: fraction
	^  ( fraction numerator * fraction denominator ) = ( numerator * denominator ).
!
argIsSmallerThanFraction: fraction
	^ ( fraction numerator * denominator ) < ( numerator * fraction denominator ).
!
argIsSmallerOrEqualToFraction: fraction
	^ ( fraction numerator * denominator ) <= ( numerator * fraction denominator ).
!

"Comparisons with float arguments."

argIsEqualToFloat: float
	^ float = self toFloat.
!
argIsSmallerThanFloat: float
	^ float < self toFloat.
!
argIsSmallerOrEqualToFloat: float
	^ float <= self toFloat.
!

"Basic arithmatic with number subsclass arguments.
 Delegates to fraction methods of argument."

+ number
	^ number addToFraction: self.
!
- number
	^ number subtractFromFraction: self.
!
* number
	^ number multiplyByFraction: self.
!
/ number
	^ number divideIntoFraction: self.
!
// number
	^ number integerDivideIntoFraction: self.
!
% number
	^ number moduloFromFraction: self.
!

"Basic arithmatic with integer arguments."

addToInteger: integer
	^ Fraction numerator: integer * denominator + numerator
		denominator: denominator.
!
subtractFromInteger: integer
	^ Fraction numerator: integer * denominator - numerator
		denominator: denominator.
!
multiplyByInteger: integer
	^ Fraction numerator: integer * numerator
		denominator: denominator.
!
divideIntoInteger: integer
	^ Fraction numerator: integer * denominator
		denominator: numerator.
!
integerDivideIntoInteger: integer
	^ ( integer * denominator ) // numerator.
!
moduloFromInteger: integer
	^ ( integer * denominator ) % numerator / denominator.
!

addToBigInt: bigInt
	^ Fraction numerator: bigInt * denominator + numerator
		denominator: denominator.
!
subtractFromBigInt: bigInt
	^ Fraction numerator: bigInt * denominator - numerator
		denominator: denominator.
!
multiplyByBigInt: bigInt
	^ Fraction numerator: bigInt * numerator
		denominator: denominator.
!
divideIntoBigInt: bigInt
	^ Fraction numerator: bigInt * denominator
		denominator: numerator.
!
integerDivideIntoBigInt: bigInt
	^ ( bigInt * denominator ) // numerator.
!
moduloFromBigInt: bigInt
	^ ( bigInt * denominator ) % numerator / denominator.
!

"Basic arithmatic with fraction arguments."

addToFraction: fraction
	^ Fraction numerator: ( fraction numerator * denominator ) + ( numerator * fraction denominator )
		denominator: fraction denominator * denominator.
!
subtractFromFraction: fraction
	^ Fraction numerator: ( fraction numerator * denominator ) - ( numerator * fraction denominator )
		denominator: fraction denominator * denominator.
!
multiplyByFraction: fraction
	^ Fraction numerator: fraction numerator * numerator
		denominator: fraction denominator * denominator.
!
divideIntoFraction: fraction
	^ Fraction numerator: fraction numerator * denominator
		denominator: fraction denominator * numerator.
!
integerDivideIntoFraction: fraction
	^ ( fraction numerator * denominator ) //
		( fraction denominator * numerator ).
!
moduloFromFraction: fraction
	^ ( fraction numerator * denominator ) % ( numerator * fraction denominator ) /
		( fraction denominator * denominator ).
!

"Basic arithmatic with float arguments."

addToFloat: float
	^ float + self toFloat.
!
subtractFromFloat: float
	^ float - self toFloat.
!
multiplyByFloat: float
	^ float * self toFloat.
!
divideIntoFloat: float
	^ float / self toFloat.
!
integerDivideIntoFloat: float
	^ float // self toFloat.
!
moduloFromFloat: float
	^ float % self toFloat.
!

"Basic arithmatic with points
 is implementend in superclass Number."

"Other arithmatic."

negated
	^ Fraction numerator: numerator negated denominator: denominator.
!
