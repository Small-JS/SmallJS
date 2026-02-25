CLASS TestBallsApp EXTENDS Object MODULE TestBallsApp CLASSVARS '' VARS 'ballsApp'

"Test BallsApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	ballsApp := BallsApp new start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestBall all.
	await self testGui.
!
async testGui
	"Set the ball count to 4.
	Press the start button.
	Check if app is running.
	Press stop button. Wait 3 sec.
	Check if the app has stopped and ran with 4 balls.
	Terminate app."

	ballsApp ballsInput value: 4.
	ballsApp startButton click.
	await Timer timeout: 3000.
	self assert: [ ballsApp stopRequested not ].
	self assert: [ ballsApp timer id notNil ].

	ballsApp stopButton click.
	await Timer timeout: 2000.
	self assert: [ ballsApp stopRequested ].
	self assert: [ ballsApp balls length = 4 ].

	ballsApp stop.
!
