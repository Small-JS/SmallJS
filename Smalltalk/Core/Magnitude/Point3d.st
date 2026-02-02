CLASS Point3d EXTENDS Point MODULE Core CLASSVARS '' VARS 'z'
	"Encapsulates a 3D point with x, y, z coordinates."

CLASSMETHODS

x: x y: y z: z
	^ self new x: x; y: y; z: z.
!
jsX: jsX jsY: jsY jsZ: jsZ
	^ self x: ( Integer fromJs: jsX ) y: ( Integer fromJs: jsY ) z: ( Integer fromJs: jsZ ).
!

METHODS

"Accessing"

z
	^ z.
!
z: aZ
	z := aZ.
!

"Converting"

toString
	^ '( ', x toString, ' @ ', y toString, ' @ ', z toString, ' )'.
!

"Comparisons with point3d arguments."

= point3d
	^ ( x = point3d x ) & ( y = point3d y ) & ( z = point3d z ).
!
< point3d
	^ ( x < point3d x ) & ( y < point3d y ) ( z < point3d z ).
!
<= point3d
	^ ( x <= point3d x ) & ( y <= point3d y ) & ( z <= point3d z ).
!

"These larger-than operators cannot be inherited
because a < b does not always imply b > a"

> point3d
	^ ( x > point3d x ) & ( y > point3d y ) & ( z > point3d z ).
!
>= point3d
	^ ( x >= point3d x ) & ( y >= point3d y ) & ( z >= point3d z ).
!

"Basic arithmatic with magnitude (number or point3d) subsclass arguments.
 Delegates to point3d handling methods of argument."

+ magnitude
	^ magnitude addToPoint3d: self.
!
- magnitude
	^ magnitude subtractFromPoint3d: self.
!
* magnitude
	^ magnitude multiplyByPoint3d: self.
!
/ magnitude
	^ magnitude divideIntoPoint3d: self.
!
// magnitude
	^ magnitude integerDivideIntoPoint3d: self.
!
% magnitude
	^ magnitude moduloFromPoint3d: self.
!

"Basic arithmatic with integer arguments."

addToInteger: integer
	^ Point3d x: integer + x  y: integer + y  z: integer + z.
!
subtractFromInteger: integer
	^ Point3d x: integer - x  y: integer - y  z: integer - z.
!
multiplyByInteger: integer
	^ Point3d x: integer * x  y: integer * y  z: integer * z.
!
divideIntoInteger: integer
	^ Point3d x: integer / x  y: integer / y  z: integer / z.
!
integerDivideIntoInteger: integer
	^ Point3d x: integer // x  y: integer // y  z: integer // z.
!
moduloFromInteger: integer
	^ Point3d x: integer % x  y: integer % y  z: integer % z.
!

"Basic arithmatic with large integer arguments."

addToBigInt: bigInt
	^ Point3d x: bigInt + x  y: bigInt + y  z: bigInt + z.
!
subtractFromBigInt: bigInt
	^ Point3d x: bigInt - x  y: bigInt - y  z: bigInt - z.
!
multiplyByBigInt: bigInt
	^ Point3d x: bigInt * x  y: bigInt * y  z: bigInt * z.
!
divideIntoBigInt: bigInt
	^ Point3d x: bigInt / x  y: bigInt / y  z: bigInt / z.
!
integerDivideIntoBigInt: bigInt
	^ Point3d x: bigInt // x  y: bigInt // y  z: bigInt // z.
!
moduloFromBigInt: bigInt
	^ Point3d x: bigInt % x  y: bigInt % y  z: bigInt % z.
!

"Basic arithmatic with fraction arguments."

addToFraction: fraction
	^ Point3d x: fraction + x  y: fraction + y  z: fraction + z.
!
subtractFromFraction: fraction
	^ Point3d x: fraction - x  y: fraction - y  z: fraction - z.
!
multiplyByFraction: fraction
	^ Point3d x: fraction * x  y: fraction * y  z: fraction * z.
!
divideIntoFraction: fraction
	^ Point3d x: fraction / x  y: fraction / y  z: fraction / z.
!
integerDivideIntoFraction: fraction
	^ Point3d x: fraction // x  y: fraction // y  z: fraction // z.
!
moduloFromFraction: fraction
	^ Point3d x: fraction % x  y: fraction % y  z: fraction % z.
!

"Basic arithmatic with float arguments."

addToFloat: float
	^ Point3d x: float + x  y: float + y  z: float + z.
!
subtractFromFloat: float
	^ Point3d x: float - x  y: float - y  z: float - z.
!
multiplyByFloat: float
	^ Point3d x: float * x  y: float * y  z: float * z.
!
divideIntoFloat: float
	^ Point3d x: float / x  y: float / y  z: float / z.
!
integerDivideIntoFloat: float
	^ Point3d x: float // x  y: float // y  z: float // z.
!
moduloFromFloat: float
	^ Point3d x: float % x  y: float % y  z: float % z.
!

"Basic arithmatic with point3d arguments."

addToPoint3d: point3d
	^ Point3d x: point3d x + x  y: point3d y + y  z: point3d z + z.
!
subtractFromPoint3d: point3d
	^ Point3d x: point3d x - x  y: point3d y - y  z: point3d z - z.
!
multiplyByPoint3d: point3d
	^ Point3d x: point3d x * x  y: point3d y * y  z: point3d z * z.
!
divideIntoPoint3d: point3d
	^ Point3d x: point3d x / x  y: point3d y / y  z: point3d z / z.
!
integerDivideIntoPoint3d: point3d
	^ Point3d x: point3d x // x  y: point3d y // y  z: point3d z // z.
!
moduloFromPoint3d: point3d
	^ Point3d x: point3d x % x  y: point3d y % y  z: point3d z % z.
!

"Other arithmatic."

negated
	^ Point3d x: x negated  y: y negated  z: z negated.
!
abs
	^ Point3d x: x abs  y: y abs  z: z abs.
!
dotProduct: point3d
	^ ( x * point3d x ) + ( y * point3d y ) + ( z * point3d z ).
!
