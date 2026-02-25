CLASS TestPharoClientApp EXTENDS Object MODULE TestPharoClientApp CLASSVARS ''
	VARS 'pharoClientApp'

"Test PharoClientApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	pharoClientApp := PharoClientApp new start.

	await self testGui.
!
async testGui
	"Click the 'Say Hello' button and chech the resonse."

	await Timer timeout: 1000.
	pharoClientApp helloButton click.

	await Timer timeout: 1000.
	self assert: [ pharoClientApp responseSpan textContent = 'Hello from Pharo!' ].

	await Timer timeout: 2000.
	pharoClientApp stop.
!
