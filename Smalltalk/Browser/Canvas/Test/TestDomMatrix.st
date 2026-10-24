CLASS TestDomMatrix EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"2D testing"

test2dReadOnly
	| matrix jsObject matrix2 point |

	matrix := DomMatrix new.
	self assert: [ matrix is2d ].
	self assert: [ matrix isIdentity ].

	matrix := DomMatrix init: #( 1 2 3 4 5 6 ).
	self assert: [ matrix is2d ].
	self assert: [ matrix isIdentity not ].
	self assert: [ matrix toString = 'matrix(1, 2, 3, 4, 5, 6)' ].
	self assert: [ matrix a = 1 ].
	self assert: [ matrix b = 2 ].
	self assert: [ matrix c = 3 ].
	self assert: [ matrix d = 4 ].
	self assert: [ matrix e = 5 ].
	self assert: [ matrix f = 6 ].

	jsObject := matrix toJson.
	self assert: [ ( jsObject atJsProperty: 'a' ) = 1 ].
	self assert: [ ( jsObject atJsProperty: 'b' ) = 2 ].
	self assert: [ ( jsObject atJsProperty: 'c' ) = 3 ].
	self assert: [ ( jsObject atJsProperty: 'd' ) = 4 ].
	self assert: [ ( jsObject atJsProperty: 'e' ) = 5 ].
	self assert: [ ( jsObject atJsProperty: 'f' ) = 6 ].

	matrix2 := matrix flipX.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( -1 -2 3 4 5 6 ) ) precision: 0.001 ].

	matrix2 := matrix flipY.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 1 2 -3 -4 5 6 ) ) precision: 0.001 ].

	matrix2 := matrix inverse.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( -2 1 1.5 -0.5 1 -2 ) ) precision: 0.001 ].

	matrix2 := matrix multiply: matrix.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 7 10 15 22 28 40 ) ) precision: 0.001 ].

	matrix2 := matrix rotateAxis: ( 1 @ 0 @ 0 ) angle: 90.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 0 0 1 0 -3 -4 0 0 5 6 0 1 ) ) precision: 0.001 ].

	matrix2 := matrix rotate: 90.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 3 4 -1 -2 5 6 ) ) precision: 0.001 ].

	matrix2 := matrix rotateFromVector: ( 1 @ 0 @ 0 ).
	self assert: [ ( matrix2 a = 1 ) & ( matrix2 b = 2 ) ].

	matrix2 := matrix scale: ( 2 @ 2 @ 2 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 6 8 0 0 0 0 2 0 5 6 0 1 ) ) precision: 0.001 ].

	point := matrix transformPoint: 1 @ 2 @ 3.
	self assert: [ ( matrix transformPoint: 1 @ 2 @ 3 ) = ( 12 @ 16 @ 3 ) ].

	matrix2 := matrix translate: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 3 4 0 0 0 0 1 0 12 16 3 1 ) ) precision: 0.001 ].
!
test2dMutating
	| matrix matrix2 point |

	matrix := DomMatrix init: #( 1 2 3 4 5 6 ).

	matrix2 := matrix copy invertSelf.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( -2 1 1.5 -0.5 1 -2 ) ) precision: 0.001 ].

	matrix2 := matrix copy multiplySelf: matrix copy.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 7 10 15 22 28 40 ) ) precision: 0.001 ].

	matrix2 := matrix copy preMultiplySelf: matrix copy.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 7 10 15 22 28 40 ) ) precision: 0.001 ].

	matrix2 := matrix copy translateSelf: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 3 4 0 0 0 0 1 0 12 16 3 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scaleSelf: 2.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 2 4 6 8 5 6 ) ) precision: 0.001 ].

	matrix2 := matrix copy scaleSelf: 3 origin: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 3 6 0 0 9 12 0 0 0 0 1 0 -9 -14 0 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scale3dSelf: ( 2 @ 3 @ 4 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 9 12 0 0 0 0 4 0 5 6 0 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scale3dSelf: ( 2 @ 3 @ 4 ) origin: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 9 12 0 0 0 0 4 0 -8 -12 -9 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy rotateSelf: ( 45 @ 45 @ 45 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 3 -0.70 0 2.41 3.12 0.5 0 0.41 1.12 0.5 0 5 6 0 1 ) ) precision: 0.1 ].

	matrix2 := matrix copy rotateAxisAngleSelf: ( 1 @ 2 @ 3 ) degrees: 90.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2.90 3.92 -0.32 0 0.19 -0.17 0.69 0 1.23 2.14 0.64 0 5 6 0 1 ) ) precision: 0.1 ].

	matrix2 := matrix copy rotateFromVectorSelf: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 3.13 4.47 0.44 0 5 6 ) ) precision: 0.1 ].

	matrix2 := DomMatrix new setMatrixValue: 'scale( 2 )'.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 2 0 0 2 0 0 ) ) precision: 0.001 ].

	matrix2 := matrix copy skewXSelf: 10.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 1 2 3.17 4.35 5 6 ) ) precision: 0.1 ].

	matrix2 := matrix copy skewYSelf: 20.
	self assert: [ matrix2 equals2d: ( DomMatrix init: #( 2.09 3.45 3 4 5 6 ) ) precision: 0.1 ].
!

"3D testing"

test3dReadOnly
	| matrix jsObject matrix2 |

	matrix := DomMatrix init: #( 1 2 0 0 0 1 3 0 4 0 1 0 5 6 7 1 ).
	self assert: [ matrix is3d ].
	self assert: [ matrix is2d not ].
	self assert: [ matrix isIdentity not ].
	self assert: [ matrix toString = 'matrix3d(1, 2, 0, 0, 0, 1, 3, 0, 4, 0, 1, 0, 5, 6, 7, 1)' ].
	self assert: [ ( matrix m11 = 1 ) & ( matrix m12 = 2 ) & ( matrix m13 = 0 ) & ( matrix m14 = 0 ) ].
	self assert: [ ( matrix m21 = 0 ) & ( matrix m22 = 1 ) & ( matrix m23 = 3 ) & ( matrix m24 = 0 ) ].
	self assert: [ ( matrix m31 = 4 ) & ( matrix m32 = 0 ) & ( matrix m33 = 1 ) & ( matrix m34 = 0 ) ].
	self assert: [ ( matrix m41 = 5 ) & ( matrix m42 = 6 ) & ( matrix m43 = 7 ) & ( matrix m44 = 1 ) ].

	"The 2D properties map to the 3D properties."
	self assert: [ ( matrix a = matrix m11 ) & ( matrix b = matrix m12 ) ].
	self assert: [ ( matrix c = matrix m21 ) & ( matrix d = matrix m22 ) ].
	self assert: [ ( matrix e = matrix m41 ) & ( matrix f = matrix m42 ) ].

	jsObject := matrix toJson.
	self assert: [ ( jsObject atJsProperty: 'm11' ) = 1 ].
	self assert: [ ( jsObject atJsProperty: 'm23' ) = 3 ].
	self assert: [ ( jsObject atJsProperty: 'm31' ) = 4 ].
	self assert: [ ( jsObject atJsProperty: 'm43' ) = 7 ].
	self assert: [ ( jsObject atJsProperty: 'is2D' ) = false ].

	matrix2 := matrix copy.
	self assert: [ matrix2 equals3d: matrix precision: 0 ].
	self assert: [ matrix2 ~= matrix ].

	matrix2 := matrix flipX.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( -1 -2 0 0 0 1 3 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix flipY.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 0 -1 -3 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix inverse.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 0.04 -0.08 0.24 0 0.48 0.04 -0.12 0 -0.16 0.32 0.04 0 -1.96 -2.08 -0.76 1 ) ) precision: 0.001 ].
	self assert: [ ( matrix multiply: matrix2 ) equals3d: ( DomMatrix init: #( 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 ) ) precision: 0.001 ].

	matrix2 := matrix multiply: ( DomMatrix init: #( 2 0 0 0 0 1 0 0 0 0 1 0 1 2 3 1 ) ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 1 3 0 4 0 1 0 18 10 16 1 ) ) precision: 0.001 ].

	matrix2 := matrix rotateAxis: ( 1 @ 0 @ 0 ) angle: 90.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 4 0 1 0 0 -1 -3 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix rotate: 90.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 0 1 3 0 -1 -2 0 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix rotateFromVector: ( 1 @ 1 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 0.707 2.121 2.121 0 -0.707 -0.707 2.121 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix scale: ( 2 @ 3 @ 4 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 3 9 0 16 0 4 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix scale: ( 2 @ 3 @ 4 ) origin: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 3 9 0 16 0 4 0 -32 0 -14 1 ) ) precision: 0.001 ].

	self assert: [ ( matrix transformPoint: 1 @ 2 @ 3 ) = ( 18 @ 10 @ 16 ) ].

	matrix2 := matrix translate: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 0 1 3 0 4 0 1 0 18 10 16 1 ) ) precision: 0.001 ].

	"Non-mutating methods leave the receiver unchanged."
	self assert: [ matrix toString = 'matrix3d(1, 2, 0, 0, 0, 1, 3, 0, 4, 0, 1, 0, 5, 6, 7, 1)' ].
!
test3dMutating
	| matrix matrix2 other |

	matrix := DomMatrix init: #( 1 2 0 0 0 1 3 0 4 0 1 0 5 6 7 1 ).
	other := DomMatrix init: #( 2 0 0 0 0 1 0 0 0 0 1 0 1 2 3 1 ).

	matrix2 := matrix copy invertSelf.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 0.04 -0.08 0.24 0 0.48 0.04 -0.12 0 -0.16 0.32 0.04 0 -1.96 -2.08 -0.76 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy multiplySelf: other.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 1 3 0 4 0 1 0 18 10 16 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy preMultiplySelf: other.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 2 0 0 0 1 3 0 8 0 1 0 11 8 10 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy translateSelf: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 0 1 3 0 4 0 1 0 18 10 16 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scaleSelf: 2.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 2 6 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scaleSelf: 3 origin: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 3 6 0 0 0 3 9 0 4 0 1 0 3 -2 -5 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scale3dSelf: ( 2 @ 3 @ 4 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 3 9 0 16 0 4 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scale3dSelf: ( 2 @ 3 @ 4 ) origin: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 0 3 9 0 16 0 4 0 -32 0 -14 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy rotateSelf: ( 45 @ 45 @ 45 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( -2.328 1.5 0.793 0 1.854 0.561 3.061 0 2.854 1.561 0.061 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy rotateAxisAngleSelf: ( 1 @ 2 @ 3 ) degrees: 90.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( -1.21 1.087 2.514 0 2.124 -1.032 1.553 0 3.32 1.659 1.127 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy rotateFromVectorSelf: ( 1 @ 1 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 0.707 2.121 2.121 0 -0.707 -0.707 2.121 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := DomMatrix new setMatrixValue: 'translate3d( 1px, 2px, 3px )'.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 0 0 0 0 1 0 0 0 0 1 0 1 2 3 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy skewXSelf: 10.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2 0 0 0.176 1.353 3 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy skewYSelf: 20.
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 1 2.364 1.092 0 0 1 3 0 4 0 1 0 5 6 7 1 ) ) precision: 0.001 ].

	"Mutating methods change the receiver."
	matrix2 := matrix copy.
	matrix2 translateSelf: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 m41 = 18 ].
!
