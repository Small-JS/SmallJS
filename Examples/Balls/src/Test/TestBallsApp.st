CLASS TestBallsApp EXTENDS Object MODULE TestBallsApp CLASSVARS '' VARS 'ballsApp'

"Test BallsApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aBallsApp
	ballsApp := aBallsApp.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Set the ball count to 4. Press the start button.  Wait 1000 msec.
	 Check if app is running.
	 Press stop button. Wait 100 msec.
	 Check if the app has stopped and ran with 4 balls."

	ballsApp ballsInput value: 4.
	ballsApp startButton click.
	Timer timeout: 3000 then: [
		self assert: [ ballsApp stopRequested not ].
		self assert: [ ballsApp timer id notNil ].
		ballsApp stopButton click.
		Timer timeout: 2000 then: [
			self assert: [ ballsApp stopRequested ].
			self assert: [ ballsApp balls length = 4 ].
			ballsApp stop ] ].
!
