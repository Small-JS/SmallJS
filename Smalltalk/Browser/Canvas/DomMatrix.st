CLASS DomMatrix EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class also implements DomMatrixReadOnly.
 It uses the classes Point and Point3d for point and vector operations,
 so not the class DomPoint."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new DOMMatrix()'.
!
init: array
	"Array should be either 6 or 16 float values,
	 to intialize the matrix for 2D or 3D operations respectively."
	^ self fromJs: INLINE 'new DOMMatrix( array.$toJs() )'.
!
fromMatrix: matrix
	^ DomMatrix fromJs: INLINE 'DOMMatrix.fromMatrix( matrix.js )'
!

METHODS

"Accessing - 2D"

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

"Accessing - 3D"

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
copy
	^ DomMatrix fromMatrix: self.
!

"Testing"

is2d
	^ Boolean fromJs: INLINE 'this.js.is2D'.
!
is3d
	^ self is2d not.
!
isIdentity
	^ Boolean fromJs: INLINE 'this.js.isIdentity'.
!

"Comparing"

equals2d: matrix precision: precision
	^ self is2d & matrix is2d &
		( ( self a - matrix a ) abs <= precision ) &
		( ( self b - matrix b ) abs <= precision ) &
		( ( self c - matrix c ) abs <= precision ) &
		( ( self d - matrix d ) abs <= precision ) &
		( ( self e - matrix e ) abs <= precision ) &
		( ( self f - matrix f ) abs <= precision ).
!

equals3d: matrix precision: precision
	^ self is3d & matrix is3d &
		( ( self m11 - matrix m11 ) abs <= precision ) &
		( ( self m12 - matrix m12 ) abs <= precision ) &
		( ( self m13 - matrix m13 ) abs <= precision ) &
		( ( self m14 - matrix m14 ) abs <= precision ) &
		( ( self m21 - matrix m21 ) abs <= precision ) &
		( ( self m22 - matrix m22 ) abs <= precision ) &
		( ( self m23 - matrix m23 ) abs <= precision ) &
		( ( self m24 - matrix m24 ) abs <= precision ) &
		( ( self m31 - matrix m31 ) abs <= precision ) &
		( ( self m32 - matrix m32 ) abs <= precision ) &
		( ( self m33 - matrix m33 ) abs <= precision ) &
		( ( self m34 - matrix m34 ) abs <= precision ) &
		( ( self m41 - matrix m41 ) abs <= precision ) &
		( ( self m42 - matrix m42 ) abs <= precision ) &
		( ( self m43 - matrix m43 ) abs <= precision ) &
		( ( self m44 - matrix m44 ) abs <= precision ).
!

"Arithmetic, non-mutating"

flipX
	^ DomMatrix fromJs: INLINE 'this.js.flipX()'.
!
flipY
	^ DomMatrix fromJs: INLINE 'this.js.flipY()'.
!
inverse
	^ DomMatrix fromJs: INLINE 'this.js.inverse()'.
!
multiply: matrix
	^ DomMatrix fromJs: INLINE 'this.js.multiply( matrix.js )'.
!
rotateAxis: degrees3d angle: angle
	^ DomMatrix fromJs: INLINE 'this.js.rotateAxisAngle( degrees3d.x.js, degrees3d.y.js,  degrees3d.z.js, angle.js )'.
!
rotate: angle
	^ DomMatrix fromJs: INLINE 'this.js.rotate( angle.js )'.
!
rotateFromVector: point3d
	^ DomMatrix fromJs: INLINE 'this.js.rotate( point3d.x.js, point3d.y.js, point3d.z.js )'.
!
scale: scale3d
	^ DomMatrix fromJs: INLINE 'this.js.rotate( scale3d.x.js, scale3d.y.js, scale3d.z.js )'.
!
scale: scale3d origin: origin3d
	^ DomMatrix fromJs: INLINE 'this.js.rotate( scale3d.x.js, scale3d.y.js, scale3d.z.js, origin3d.x.js, origin3d.y.js, origin3d.z.js  )'.
!
transformPoint: point3d
	| domPoint result |
	domPoint := DomPoint fromPoint3d: point3d.
	result := DomPoint fromJs: INLINE 'this.js.transformPoint( domPoint.js )'.
	^ result toPoint3d.
!
translate: point3d
	| domPoint |
	domPoint := DomPoint fromPoint3d: point3d.
	^ DomMatrix fromJs: INLINE 'this.js.translate( domPoint.js.x, domPoint.js.y, domPoint.js.z )'.
!

"Arithmetic, mutating"

invertSelf
	INLINE 'this.js.invertSelf()'.
!
multiplySelf: matrix
	INLINE 'this.js.multiplySelf( matrix.js )'.
!
preMultiplySelf: matrix
	INLINE 'this.js.preMultiplySelf( matrix.js )'.
!
translateSelf: point3d
	INLINE 'this.js.translateSelf( point3d.x.js, point3d.y.js, point3d.z.js )'.
!

scaleSelf: scale
	INLINE 'this.js.scaleSelf( scale.js )'.
!
scaleSelf: scale origin: origin
	INLINE 'this.js.scaleSelf( scale.js, origin.x.js, origin.y.js, origin.z.js )'.
!
scale3dSelf: scale3d
	INLINE 'this.js.scale3dSelf( scale3d.x.js, scale3d.y.js, scale3d.z.js )'.
!
scale3dSelf: scale3d origin: origin
	INLINE 'this.js.scale3dSelf( scale3d.x.js, scale3d.y.js, scale3d.z.js, origin.x.js, origin.y.js, origin.z.js )'.
!

rotateSelf: degrees3d
	INLINE 'this.js.rotateSelf( degrees3d.x.js, degrees3d.y.js, degrees3d.z.js )'.
!
rotateAxisAngleSelf: point3d degrees: degrees
	INLINE 'this.js.rotateAxisAngleSelf( point3d.x.js, point3d.y.js, point3d.z.js, degrees.js )'.
!
rotateFromVectorSelf: point
	INLINE 'this.js.rotateFromVectorSelf( point.x.js, point.y.js )'.
!

skewXSelf: degrees
	INLINE 'this.js.skewXSelf( degrees.js )'.
!
skewYSelf: degrees
	INLINE 'this.js.skewYSelf( degrees.js )'.
!

setMatrixValue: transform "string"
	INLINE 'this.js.setMatrixValue( transform.js )'.
!
