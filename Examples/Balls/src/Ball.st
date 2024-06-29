CLASS Ball EXTENDS Object MODULE BallsApp CLASSVARS '' VARS 'radius position speed color'

CLASSMETHODS

"Creating"

newIn: bounds
	| ball speed |
	ball := Ball new.
	ball radius: 16.
	ball position: ( Integer randomFrom: ball radius to: bounds x - ball radius ) @
			( Integer randomFrom: ball radius to: bounds y - ball radius ).
	ball speed: ( self randomSpeed ) @ ( self randomSpeed ).
	ball color: ( #( 'red' 'blue' 'green' ) at: ( Integer randomFrom: 0 to: 2 ) ).
	^ ball.
!
randomSpeed
	"Random speed for single direction, x or y."
	| speed |
	speed := Integer randomFrom: 2 to: 10.
	^ Float random < 0.5 ifTrue: [ speed ] ifFalse: [ speed negated ].
!
METHODS

"Accessing"

color
	^ color.
!
color: aColor
	color := aColor.
!
radius
	^ radius.
!
radius: aSize
	radius := aSize.
!
position
	^ position.
!
position: aPosition
	position := aPosition.
!
speed
	^ speed.
!
speed: aDelta
	speed := aDelta.
!

"Moving"

moveIn: bounds
	| x y |
	"Move the position of this ball with speed within the argument bounds point.
	 Bounce the ball if it goes outside bounds.I.e.: Reverse x and/or y speed."

	speed x < 0 & ( position x - radius + speed x < 0 ) ifTrue: [ speed x: speed x negated ].
	speed x > 0 & ( position x + radius + speed x > bounds x ) ifTrue: [ speed x: speed x negated ].
	speed y < 0 & ( position y - radius + speed y < 0 ) ifTrue: [ speed y: speed y negated ].
	speed y > 0 & ( position y + radius + speed y > bounds y ) ifTrue: [ speed y: speed y negated ].

	position := position + speed.
!
