CLASS BallsApp EXTENDS BrowserApp MODULE BallsApp CLASSVARS ''
	VARS 'balls stopRequested timer
		canvas context ballsInput startButton stopButton'

start
	self bindElements.
	self initialize.

	self testMode ifTrue: [
		TestBallsApp new test: self ].
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	canvas := Document getElementById: 'canvas' class: HtmlCanvasElement.

	ballsInput := Document getElementById: 'ballsInput' class: HtmlInputElement.

	startButton := Document getElementById: 'startButton' class: HtmlButtonElement.
	startButton onClick: [ self startMoving ].

	stopButton := Document getElementById: 'stopButton' class: HtmlButtonElement.
	stopButton onClick: [ self stopMoving ].
!
initialize
	context := canvas getContext: '2d'.
	timer := Timer new.
!
startMoving
	| ballCount |

	timer clearTimeout. 	"In case it was running."

	balls := Array new.
	ballCount := ballsInput value toInteger max: 1.
	ballCount timesRepeat: [
		balls add: ( Ball newIn: canvas size ) ].

	stopRequested := false.
	self move.
!
move
	"Move balls and redraw canvas"
	stopRequested ifTrue: [ ^ self ].

	context clearRect: ( Rect origin: 0 @ 0 extent: canvas size ).

	balls do: [ :ball |
		ball moveIn: canvas size.
		self drawBall: ball ].

	timer timeout: 100 then: [ self move ].
!
drawBall: ball
	| radius topRight bottomLeft gradient |

	radius := ball radius.
	topRight := ball position + ( Point x: radius y: radius negated ).
	bottomLeft := ball position + ( Point x: radius negated y: radius ).

	gradient := context createLinearGradientFrom: topRight to: bottomLeft.
	gradient addColorStop: 0 color: 'white'.
	gradient addColorStop: 0.4 color: ball color.
	gradient addColorStop: 1 color: '#101010'.

	context beginPath.
	context fillStyle: gradient.
	context arc: ball position radius: ball radius startAngle: 0 endAngle: Float pi * 2 counterclockwise: false.
	context fill.
	context closePath.
!
stopMoving
	stopRequested := true.
!

"Accessing elements (used by tests)"

ballsInput
	^ ballsInput.
!
startButton
	^ startButton.
!
stopButton
	^ stopButton.
!

"Accessing variables (used by tests)"

balls
	^ balls.
!
stopRequested
	^ stopRequested.
!
timer
	^ timer.
!
