CLASS QPoint EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

"A point in a two-dimensional plane, with integer x and y coordinates."

CLASSMETHODS

new
	"Answer the point 0, 0."
	^ self fromJs: INLINE 'new nodegui$.QPoint()'.
!
x: x y: y
	^ self fromJs: INLINE 'new nodegui$.QPoint( x.js, y.js )'.
!
fromVariant: variant
	"Answer the point held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QPoint.fromQVariant( variant.js )'.
!

METHODS

"Comparing"

= point
	"Points are equal if their x and y are equal."
	^ ( point isKindOf: QPoint ) and: [ ( self x = point x ) & ( self y = point y ) ].
!

"Accessing"

x
	^ Integer fromJs: INLINE 'this.js.x()'.
!
setX: x
	INLINE 'this.js.setX( x.js )'.
!
y
	^ Integer fromJs: INLINE 'this.js.y()'.
!
setY: y
	INLINE 'this.js.setY( y.js )'.
!

"Testing"

isZero
	"Answer true if both x and y are 0.
	 JS isNull(), not named isNull, which is used by JsObject to test for a JS null."
	^ Boolean fromJs: INLINE 'this.js.isNull()'.
!

"Converting"

manhattanLength
	"Answer the sum of the absolute values of x and y."
	^ Integer fromJs: INLINE 'this.js.manhattanLength()'.
!
transposed
	"Answer a new point with x and y swapped."
	^ QPoint fromJs: INLINE 'this.js.transposed()'.
!

"Printing"

toString
	^ 'QPoint( ', self x toString, ', ', self y toString, ' )'.
!
