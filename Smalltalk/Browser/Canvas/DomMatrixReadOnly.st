CLASS DomMatrixReadOnly EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

is2d
	^ Boolean fromJs: INLINE 'this.js.is2D()'.
!
isIdentity
	^ Boolean fromJs: INLINE 'this.js.isIdentity()'.
!
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
rotateAxis: point3d angle: angle
	^ DomMatrix fromJs: INLINE 'this.js.rotateAxis( point3d.x.js, point3d.y.js, point3d.z.js, angle.js )'.
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
toJson
	^ String fromJs: INLINE 'this.js.toJSON()'.
!
toString
	^ String fromJs: INLINE 'this.js.toString()'.
!

"DOMMatrixReadOnly.transformPoint()
Transforms the specified point using the matrix, returning a new DOMPoint object containing the transformed point. Neither the matrix nor the original point are altered.

DOMMatrixReadOnly.translate()
Returns a new DOMMatrix containing a matrix calculated by translating the source matrix using the specified vector. By default, the vector is (0, 0, 0). The original matrix is not changed."