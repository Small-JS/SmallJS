CLASS TestPoint3d EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| point3d  |

	point3d := Point3d fromArray: #( 1 2 3 ).
	self assert: [ point3d asArray = #( 1 2 3 ) ].
	self assert: [ point3d toString = 'Point3d #( 1 2 3 )' ].

	point3d := Point3d fromX: 4 y: 5 z: 6.
	self assert: [ point3d x = 4 ].
	self assert: [ point3d y = 5 ].
	self assert: [ point3d z = 6 ].

	point3d x: 7.
	self assert: [ point3d x = 7 ].
	point3d y: 8.
	self assert: [ point3d y = 8 ].
	point3d z: 9.
	self assert: [ point3d z = 9 ].
!
