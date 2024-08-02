CLASS Number EXTENDS Magnitude MODULE Core CLASSVARS '' VARS ''
	"Abstract base class for Number classes."

INLINE 'import { NumUtil } from "./Runtime.js";'

METHODS

"Conversion."

@ number
	^ Point new x: self y: number.
!

"Basic arithmatic with Point arguments."

addToPoint: point
	^ Point x: point x + self  y: point y + self.
!
subtractFromPoint: point
	^ Point x: point x - self  y: point y - self.
!
multiplyByPoint: point
	^ Point x: point x * self  y: point y * self.
!
divideIntoPoint: point
	^ Point x: point x / self  y: point y / self.
!
integerDivideIntoPoint: point
	^ Point x: point x // self  y: point y // self.
!
moduloFromPoint: point
	^ Point x: point x % self  y: point y % self.
!

"Basic arithmatic with Point3d arguments."

addToPoint3d: point3d
	^ Point3d x: point3d x + self  y: point3d y + self  z: point3d z + self.
!
subtractFromPoint3d: point3d
	^ Point3d x: point3d x - self  y: point3d y - self  z: point3d z - self.
!
multiplyByPoint3d: point3d
	^ Point3d x: point3d x * self  y: point3d y * self  z: point3d z * self.
!
divideIntoPoint3d: point3d
	^ Point3d x: point3d x / self  y: point3d y / self  z: point3d z / self.
!
integerDivideIntoPoint3d: point3d
	^ Point3d x: point3d x // self  y: point3d y // self  z: point3d z // self.
!
moduloFromPoint3d: point3d
	^ Point3d x: point3d x % self  y: point3d y % self  z: point3d z % self.
!

"Other arithmatic."

squared
	^ self * self.
!
isSquare
	"Answer true if receiver is a square"

	self < 2 ifTrue: [ ^ false ].

	^ self toFloat sqrt toInteger squared = self.
!
sqrt
	^ self toFloat sqrt.
!
negated
	^ 0 - self.
!
abs
	^ self < 0 ifTrue: [ self negated ] ifFalse: [ self ].
!
\\ number
	^ self % number.
!

"Incrementing & decrementing. Modifies self."

increment
	"Self modifying increment"
	INLINE 'this.js++'.
!
decrement
	"Self modifying decrement"
	INLINE 'this.js--'.
!


"Errors."

divisionByZeroError
	self error: 'Error: Division by zero of number: ', self toString.
!
