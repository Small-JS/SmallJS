CLASS DomPointReadOnly EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

x: x y: y
	^ self fromJs: INLINE 'new DOMPointReadOnly( x.js, y.js )'.
!
x: x y: y z: z
	^ self fromJs: INLINE 'new DOMPointReadOnly( x.js, y.js, z.js )'.
!
x: x y: y z: z w: w
	^ self fromJs: INLINE 'new DOMPointReadOnly( x.js, y.js, z.js, w.js )'.
!
fromPoint: domPoint
	^ self fromJs: INLINE 'domPoint.js'.
!

METHODS

"Converting"

toJson
	^ String fromJs: INLINE 'this.js.toJSON()'.
!

"Accessing"

x
	^ Float fromJs: INLINE 'this.js.x'.
!
y
	^ Float fromJs: INLINE 'this.js.y'.
!
z
	^ Float fromJs: INLINE 'this.js.z'.
!
w
	^ Float fromJs: INLINE 'this.js.w'.
!
