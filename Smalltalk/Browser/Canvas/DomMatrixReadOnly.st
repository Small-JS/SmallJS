CLASS DomMatrixReadOnly EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class uses the Point and Point3d classes voor point and vector operations,
 so not the DomPoint class."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new DOMMatrixReadOnly()'.
!
init: array
	"Array should be either 6 or float values 16 values,
	 to intialize the matrix for 2D or 3D operations respectively."
	^ self fromJs: INLINE 'new DOMMatrixReadOnly( array.$toJs() )'.
!

METHODS

"Accessing 2D"

a
	^ Float fromJs: INLINE 'this.js.a'.
!
b
	^ Float fromJs: INLINE 'this.js.b'.
!
c
	^ Float fromJs: INLINE 'this.js.c'.
!
d
	^ Float fromJs: INLINE 'this.js.d'.
!
e
	^ Float fromJs: INLINE 'this.js.e'.
!
f
	^ Float fromJs: INLINE 'this.js.f'.
!

"Accessing 3D"

m11
	^ Float fromJs: INLINE 'this.js.m11'.
!
m12
	^ Float fromJs: INLINE 'this.js.m12'.
!
m13
	^ Float fromJs: INLINE 'this.js.m13'.
!
m14
	^ Float fromJs: INLINE 'this.js.m14'.
!

m21
	^ Float fromJs: INLINE 'this.js.m21'.
!
m22
	^ Float fromJs: INLINE 'this.js.m22'.
!
m23
	^ Float fromJs: INLINE 'this.js.m23'.
!
m24
	^ Float fromJs: INLINE 'this.js.m24'.
!

m31
	^ Float fromJs: INLINE 'this.js.m31'.
!
m32
	^ Float fromJs: INLINE 'this.js.m32'.
!
m33
	^ Float fromJs: INLINE 'this.js.m33'.
!
m34
	^ Float fromJs: INLINE 'this.js.m34'.
!

m41
	^ Float fromJs: INLINE 'this.js.m41'.
!
m42
	^ Float fromJs: INLINE 'this.js.m42'.
!
m43
	^ Float fromJs: INLINE 'this.js.m43'.
!
m44
	^ Float fromJs: INLINE 'this.js.m44'.
!

"Converting"

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
toJson
	^ JsObject fromJs: INLINE 'this.js.toJSON()'.
!

"Testing"

is2d
	^ Boolean fromJs: INLINE 'this.js.is2D'.
!
isIdentity
	^ Boolean fromJs: INLINE 'this.js.isIdentity'.
!

"Arithmatic"

flipX
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.flipX()'.
!
flipY
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.flipY()'.
!
inverse
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.inverse()'.
!
multiply: matrix
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.multiply( matrix.js )'.
!
rotateAxis: point3d angle: angle
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.rotateAxisAngle( point3d.x.js, point3d.y.js,  point3d.z.js, angle.js )'.
!
rotate: angle
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.rotate( angle.js )'.
!
rotateFromVector: point3d
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.rotate( point3d.x.js, point3d.y.js, point3d.z.js )'.
!
scale: scale3d
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.rotate( scale3d.x.js, scale3d.y.js, scale3d.z.js )'.
!
scale: scale3d origin: origin3d
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.rotate( scale3d.x.js, scale3d.y.js, scale3d.z.js, origin3d.x.js, origin3d.y.js, origin3d.z.js  )'.
!
transformPoint: domPoint
	^ DomPoint fromJs: INLINE 'this.js.transformPoint( domPoint.js )'.
!
translate: domPoint
	^ DomMatrixReadOnly fromJs: INLINE 'this.js.translate( domPoint.js.x, domPoint.js.y, domPoint.js.z )'.
!
