CLASS TestBall EXTENDS Test MODULE TestBallsApp CLASSVARS '' VARS ''

test
	| ball |

	ball := Ball new.

	ball color: 'red'.
	self assert: [ ball color = 'red' ].

	ball radius: 10.
	self assert: [ ball radius = 10 ].

	ball position: 30 @ 20.
	self assert: [ ball position = ( 30 @ 20 ) ].

	ball speed: 3 @ 2.
	self assert: [ ball speed = ( 3 @ 2 ) ].

	"Bounce off lower right corner."
	ball moveIn: 30 @ 20.
	self assert: [ ball position = ( 27 @ 18 ) ].
	self assert: [ ball speed = ( -3 @ -2 ) ].

	"Bounce off top left."
	ball position: 0 @ 0.
	ball moveIn: 30 @ 20.
	self assert: [ ball position = ( 3 @ 2 ) ].
	self assert: [ ball speed = ( 3 @ 2 ) ].

	ball := Ball newIn: 200 @ 100.
	self assert: [ ball class = Ball ].
	self assert: [ ball radius = 16 ].
	self assert: [ ball position x >= 0 ].
	self assert: [ ball position y >= 0 ].
	self assert: [ self checkSpeedCoordinate: ball speed x ].
	self assert: [ self checkSpeedCoordinate: ball speed y ].
	self assert: [ #( 'red' 'blue' 'green' ) includes: ball color ].
!
checkSpeedCoordinate: speed
	^ ( speed >= -10 ) & ( speed <= -2 ) |
	  ( speed >= 2 ) & ( speed <= 10 ).
!
