CLASS TestDomMatrixReadOnly EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test2d
	| matrix jsObject matrix2 point |

	matrix := DomMatrixReadOnly new.
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
	self assert: [ matrix2 toString = 'matrix(-1, -2, 3, 4, 5, 6)' ].

	matrix2 := matrix flipY.
	self assert: [ matrix2 toString = 'matrix(1, 2, -3, -4, 5, 6)' ].

	matrix2 := matrix inverse.
	self assert: [ matrix2 toString = 'matrix(-2, 1, 1.5, -0.5, 1, -2)' ].

	matrix2 := matrix multiply: matrix.
	self assert: [ matrix2 toString = 'matrix(7, 10, 15, 22, 28, 40)' ].

	matrix2 := matrix rotateAxis: ( 1 @ 0 @ 0 ) angle: 90.
	self assert: [ matrix2 toString = 'matrix3d(1, 2, 0, 0, 0, 0, 1, 0, -3, -4, 0, 0, 5, 6, 0, 1)' ].

	matrix2 := matrix rotate: 90.
self log: matrix2 toString.
	self assert: [ matrix2 toString = 'matrix(3, 4, -1, -2, 5, 6)' ].

	matrix2 := matrix rotateFromVector: ( 1 @ 0 @ 0 ).
	self assert: [ ( matrix2 a = 1 ) & ( matrix2 b = 2 ) ].

	matrix2 := matrix scale: ( 2 @ 2 @ 2 ).
	self assert: [ ( matrix2 a * 10 ) toInteger = 11 ].

	point := matrix transformPoint: ( DomPoint x: 1 y: 2 z: 3 ).
	self assert: [ point = ( DomPoint x: 12 y: 16 z: 3 w: 1 ) ].

	matrix2 := matrix translate: ( DomPoint x: 1 y: 2 z: 3 ).
	self assert: [ matrix2 toString = 'matrix3d(1, 2, 0, 0, 3, 4, 0, 0, 0, 0, 1, 0, 12, 16, 3, 1)' ].
!

translate: point3d
	^ self new fromJs: INLINE 'this.js.translate( point3d.js.x, mapoint3dtrix.js.y, point3d.js.z )'.
!

test3d
	| matrix jsObject |

	matrix := DomMatrixReadOnly init:
		#( 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ).
	self assert: [ matrix is2d not ].
!
