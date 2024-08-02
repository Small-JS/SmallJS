CLASS DomPoint EXTENDS DomPointReadOnly MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

x: x y: y
	^ self fromJs: INLINE 'new DOMPoint( x.js, y.js )'.
!
x: x y: y z: z
	^ self fromJs: INLINE 'new DOMPoint( x.js, y.js, z.js )'.
!
x: x y: y z: z w: w
	^ self fromJs: INLINE 'new DOMPoint( x.js, y.js, z.js, w.js )'.
!
formPoint: point
	^ self x: point x y: point y z: point z.
!

METHODS

x: x
	INLINE 'this.js.x = x.js'.
!
y: y
	INLINE 'this.js.y = y.js'.
!
z: z
	INLINE 'this.js.z = z.js'.
!
w: w
	INLINE 'this.js.w = w.js'.
!

"Comparing"

= domPoint
	^ ( self x = domPoint x ) & ( self y = domPoint y ) &
		( self z = domPoint z ) & ( self w = domPoint w ).
!
