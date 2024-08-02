CLASS Point EXTENDS Object MODULE Core CLASSVARS '' VARS 'x y'

	"Holds 2 ST numbers x and y. Arithmatic can be done the point as a whole this."

CLASSMETHODS

x: x  y: y
	^ self new x: x  y: y.
!
jsX: jsX jsY: jsY
	^ self x: ( Integer fromJs: jsX ) y: ( Integer fromJs: jsY ).
!

METHODS

"Converting"

toString
	^ '( ', x toString, ' @ ', y toString, ' )'.
!
@ z
	^ Point3d x: x y: y z: z.
!

"Accessing."

x
	^ x.
!
x: aX
	x := aX.
!
y
	^ y.
!
y: aY
	y := aY.
!
x: aX y: aY
	x := aX.
	y := aY.
!
z
	"Assume 2d poin is at z = 0 in 3D plane."
	^ 0.
!

"Comparisons with point arguments."

= point
	^ ( x = point x ) & ( y = point y ).
!
< point
	^ ( x < point x ) & ( y < point y ).
!
<= point
	^ ( x <= point x ) & ( y <= point y ).
!

"These larger-than operators cannot be inherited
because a < b does not always imply b > a"

> point
	^ ( x > point x ) & ( y > point y ).
!
>= point
	^ ( x >= point x ) & ( y >= point y ).
!

"Basic arithmatic with magnitude (number or point) subsclass arguments.
 Delegates to point handling methods of argument."

+ magnitude
	^ magnitude addToPoint: self.
!
- magnitude
	^ magnitude subtractFromPoint: self.
!
* magnitude
	^ magnitude multiplyByPoint: self.
!
/ magnitude
	^ magnitude divideIntoPoint: self.
!
// magnitude
	^ magnitude integerDivideIntoPoint: self.
!
% magnitude
	^ magnitude moduloFromPoint: self.
!

"Basic arithmatic with integer arguments."

addToInteger: integer
	^ Point x: integer + x  y: integer + y.
!
subtractFromInteger: integer
	^ Point x: integer - x  y: integer - y.
!
multiplyByInteger: integer
	^ Point x: integer * x  y: integer * y.
!
divideIntoInteger: integer
	^ Point x: integer / x  y: integer / y.
!
integerDivideIntoInteger: integer
	^ Point x: integer // x  y: integer // y.
!
moduloFromInteger: integer
	^ Point x: integer % x  y: integer % y.
!

"Basic arithmatic with large integer arguments."

addToBigInt: bigInt
	^ Point x: bigInt + x  y: bigInt + y.
!
subtractFromBigInt: bigInt
	^ Point x: bigInt - x  y: bigInt - y.
!
multiplyByBigInt: bigInt
	^ Point x: bigInt * x  y: bigInt * y.
!
divideIntoBigInt: bigInt
	^ Point x: bigInt / x  y: bigInt / y.
!
integerDivideIntoBigInt: bigInt
	^ Point x: bigInt // x  y: bigInt // y.
!
moduloFromBigInt: bigInt
	^ Point x: bigInt % x  y: bigInt % y.
!

"Basic arithmatic with fraction arguments."

addToFraction: fraction
	^ Point x: fraction + x  y: fraction + y.
!
subtractFromFraction: fraction
	^ Point x: fraction - x  y: fraction - y.
!
multiplyByFraction: fraction
	^ Point x: fraction * x  y: fraction * y.
!
divideIntoFraction: fraction
	^ Point x: fraction / x  y: fraction / y.
!
integerDivideIntoFraction: fraction
	^ Point x: fraction // x  y: fraction // y.
!
moduloFromFraction: fraction
	^ Point x: fraction % x  y: fraction % y.
!

"Basic arithmatic with float arguments."

addToFloat: float
	^ Point x: float + x  y: float + y.
!
subtractFromFloat: float
	^ Point x: float - x  y: float - y.
!
multiplyByFloat: float
	^ Point x: float * x  y: float * y.
!
divideIntoFloat: float
	^ Point x: float / x  y: float / y.
!
integerDivideIntoFloat: float
	^ Point x: float // x  y: float // y.
!
moduloFromFloat: float
	^ Point x: float % x  y: float % y.
!

"Basic arithmatic with point arguments."

addToPoint: point
	^ Point x: point x + x  y: point y + y.
!
subtractFromPoint: point
	^ Point x: point x - x  y: point y - y.
!
multiplyByPoint: point
	^ Point x: point x * x  y: point y * y.
!
divideIntoPoint: point
	^ Point x: point x / x  y: point y / y.
!
integerDivideIntoPoint: point
	^ Point x: point x // x  y: point y // y.
!
moduloFromPoint: point
	^ Point x: point x % x  y: point y % y.
!

"Other arithmatic."

negated
	^ Point x: x negated y: y negated.
!
abs
	^ Point x: x abs y: y abs.
!
dotProduct: point
	^ ( x * point x ) + ( y * point y ).
!
