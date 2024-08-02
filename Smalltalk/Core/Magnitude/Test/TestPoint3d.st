CLASS TestPoint3d EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ ( Point3d x: 1 y: 2 z: 3 ) = ( 1 @ 2 @ 3 ) ].
	self assert: [ ( Point3d jsX: ( 1 js ) jsY: ( 2 js ) jsZ: ( 3 js ) ) = ( 1 @ 2 @ 3 ) ].
!
testConversion
	self assert: [ ( 1 @ 2 @ 3 ) toString = '( 1 @ 2 @ 3 )' ].
!
testAccessing
	| point3d |
	point3d := Point3d x: 1 y: 2 z: 3.

	self assert: [ point3d x = 1 ].
	self assert: [ point3d y = 2 ].
	self assert: [ point3d z = 3 ].

	point3d := 4 @ 5 @ 6.
	self assert: [ point3d x = 4 ].
	self assert: [ point3d y = 5 ].
	self assert: [ point3d z = 6 ].
!
testComparisons
	self assert: [ ( 1 @ 2 @ 3 ) = ( 1 @ 2 @ 3 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) <= ( 1 @ 2 @ 3 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) >= ( 1 @ 2 @ 3 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) < ( 2 @ 3 @ 4 ) ].
	self assert: [ ( 2 @ 3 @ 4 ) > ( 1 @ 2 @ 3 ) ].
!
testBasicArithmatic
	"Basic arithmatic with Point3d arguments."
	self assert: [ ( 1 @ 2 @ 3 ) + ( 4 @ 5 @ 6 ) = ( 5 @ 7 @ 9 ) ].
	self assert: [ ( 4 @ 5 @ 6 ) - ( 1 @ 2 @ 3 ) = ( 3 @ 3 @ 3 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) * ( 4 @ 5 @ 6 ) = ( 4 @ 10 @ 18 ) ].
	self assert: [ ( 4 @ 8 @ 16 ) / ( 2 @ 4 @ 8 ) = ( 2 @ 2 @ 2 ) ].
	self assert: [ ( 4 @ 8 @ 16 ) // ( 3 @ 5 @ 9 ) = ( 1 @ 1 @ 1 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) % ( 3 @ 5 @ 7 ) = ( 1 @ 3 @ 5 ) ].

	"Basic arithmatic with Integer arguments."
	self assert: [ ( 1 @ 2 @ 3 ) + 4 = ( 5 @ 6 @ 7 ) ].
	self assert: [ ( 3 @ 4 @ 5 ) - 2 = ( 1 @ 2 @ 3 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) * 4 = ( 4 @ 8 @ 12 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) / 2 = ( 2 @ 4 @ 6 ) ].
	self assert: [ ( 4 @ 8 @ 10 ) // 3 = ( 1 @ 2 @ 3 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) % 3 = ( 1 @ 2 @ 0 ) ].

	"Basic arithmatic with large integer arguments."
	self assert: [ ( 1 @ 2 @ 3 ) + 4 toBigInt = ( 5 @ 6 @ 7 ) ].
	self assert: [ ( 5 @ 6 @ 7 ) - 2 toBigInt = ( 3 @ 4 @ 5 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) * 3 toBigInt = ( 3 @ 6 @ 9 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) / 2 toBigInt = ( 2 @ 4 @ 6 ) ].
	self assert: [ ( 4 @ 8 @ 12  ) // 3 toBigInt = ( 1 @ 2 @ 4 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) % 3 toBigInt = ( 1 @ 2 @ 0 ) ].

	"Basic arithmatic with float arguments."
	self assert: [ ( 1 @ 2 @ 3 ) + 3.5 = ( 4.5 @ 5.5 @ 6.5 ) ].
	self assert: [ ( 3 @ 4 @ 5 ) - 2.5 = ( 0.5 @ 1.5 @ 2.5 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) * 1.5 = ( 1.5 @ 3.0 @ 4.5 ) ].
	self assert: [ ( 3 @ 7 @ 8 ) / 2.0 = ( 1.5 @ 3.5 @ 4.0 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) // 3.5 = ( 1.0 @ 2.0 @ 3.0 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) % 3.5 = ( 0.5 @ 1.0 @ 1.5  ) ].

	"Basic arithmatic with fraction arguments."
	self assert: [ ( 1 @ 2 @ 3 ) + ( 1 / 2 ) = ( ( 3 / 2 ) @ ( 5 / 2 ) @ ( 7 / 2 ) ) ].
	self assert: [ ( 3 @ 4 @ 5 ) - ( 1 / 2 ) = ( ( 5 / 2 ) @ ( 7 / 2 ) @ ( 9 / 2 ) ) ].
	self assert: [ ( 1 @ 2 @ 3 ) * ( 1 / 2 ) = ( ( 1 / 2 ) @ 1 @ ( 3 / 2 ) ) ].
	self assert: [ ( 3 @ 7 @ 9 ) / ( 1 / 2 ) = ( 6 @ 14 @ 18 ) ].
	self assert: [ ( 4 @ 8 @ 12 ) // ( 4 / 3 ) = ( 3 @ 6 @ 9 ) ].
	self assert: [ ( 1 @ 2 @ 3 ) % ( 2 / 3 ) = ( ( 1 / 3 ) @ 0 @ ( 1 / 3 ) ) ].

!
testFunctions
	self assert: [ ( 2 @ 3 @ 4 ) negated = ( -2 @ -3 @ -4 ) ].
	self assert: [ ( -2 @ -3 @ -4 ) abs = ( 2 @ 3 @ 4 ) ].
	self assert: [ ( ( 2 @ 3 @ 4 ) dotProduct: ( 4 @ 5 @ 6 ) ) = 47 ].
!
