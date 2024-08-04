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
	self assert: [ ( matrix2 a * 10 ) toInteger = 11 ].

	point := matrix transformPoint: ( DomPoint x: 1 y: 2 z: 3 ).
	self assert: [ point = ( DomPoint x: 12 y: 16 z: 3 w: 1 ) ].

	matrix2 := matrix translate: ( DomPoint x: 1 y: 2 z: 3 ).
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
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 3 6 0 0 3 4 0 0 0 0 2 0 -1 -6 0 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scale3dSelf: ( 2 @ 3 @ 4 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 6 8 0 0 0 0 2 0 -10 -16 0 1 ) ) precision: 0.001 ].

	matrix2 := matrix copy scale3dSelf: ( 2 @ 3 @ 4 ) origin: ( 1 @ 2 @ 3 ).
	self assert: [ matrix2 equals3d: ( DomMatrix init: #( 2 4 0 0 6 8 0 0 0 0 2 0 -10 -16 -1 1 ) ) precision: 0.001 ].

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

test3d
	| matrix jsObject |

	matrix := DomMatrix init: #( 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ).
	self assert: [ matrix is3d ].
!

"TODO: more...?"
