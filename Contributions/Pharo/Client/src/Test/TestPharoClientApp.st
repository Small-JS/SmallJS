CLASS TestPharoClientApp EXTENDS Object MODULE TestPharoClientApp CLASSVARS '' VARS 'pharoClientApp'

"Test PharoClientApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aPharoClientApp
	pharoClientApp := aPharoClientApp.

	self testGui.
!
testGui
	"Click the 'Say Hello' button and chech the resonse."

	Timer timeout: 1000 then: [
		pharoClientApp helloButton click.
		Timer timeout: 1000 then: [
			self assert: [ pharoClientApp responseSpan textContent = 'Hello from Pharo!' ].
			Timer timeout: 2000 then: [
				pharoClientApp stop ] ] ].
!
