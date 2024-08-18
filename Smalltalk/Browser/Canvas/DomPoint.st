CLASS DomPoint EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class also implements DomPointReadOnly."

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
fromPoint: point
	^ self x: point x y: point y.
!
fromPoint3d: point3d
	^ self x: point3d x y: point3d y z: point3d z.
!
fromDomPoint: domPoint
	^ DomPoint fromJs: INLINE 'DOMPoint.fromPoint( domPoint.js )'.
!

METHODS

"Converting"

toJson
	^ String fromJs: INLINE 'this.js.toJSON()'.
!
copy
	^ DomPoint fromDomPoint: self.
!
toPoint
	^ Point x: self x y: self y.
!
toPoint3d
	^ Point3d x: self x y: self y z: self z.
!

"Accessing"

x
	^ Float fromJs: INLINE 'this.js.x'.
!
x: x
	INLINE 'this.js.x = x.js'.
!
y
	^ Float fromJs: INLINE 'this.js.y'.
!
y: y
	INLINE 'this.js.y = y.js'.
!
z
	^ Float fromJs: INLINE 'this.js.z'.
!
z: z
	INLINE 'this.js.z = z.js'.
!
w
	^ Float fromJs: INLINE 'this.js.w'.
!

w: w
	INLINE 'this.js.w = w.js'.
!

"Comparing"

= domPoint
	^ ( self x = domPoint x ) & ( self y = domPoint y ) &
		( self z = domPoint z ) & ( self w = domPoint w ).
!
