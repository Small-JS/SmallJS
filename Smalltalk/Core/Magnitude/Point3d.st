CLASS Point3d EXTENDS Object MODULE Core CLASSVARS '' VARS 'x y z'
	"Encapsulates a 3D point3d with x, y, z coordinates."

CLASSMETHODS

fromArray: values
	^ self new x: ( values at: 0 ); y: ( values at: 1 ); z: ( values at: 2 ).
!
fromX: x y: y z: z
	^ self new x: x; y: y; z: z.
!

METHODS

asArray
	| array |
	^ Array new add: x; add: y; add: z.
!
toString
	^ 'Point3d ', self asArray toString.
!
x
	^ x.
!
x: aX
	x := aX.
!
y
	^ y.
!
y: aY
	y := aY.
!
z
	^ z.
!
z: aZ
	z := aZ.
!
