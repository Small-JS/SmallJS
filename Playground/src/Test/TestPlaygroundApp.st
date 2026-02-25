CLASS TestPlaygroundApp EXTENDS Object MODULE TestPlaygroundApp CLASSVARS '' VARS 'playgroundApp'

"Test PlaygroundApp units and GUI.
 This class is not a subclass of Test, so it's not called automatically with Test all."

async start
	playgroundApp := PlaygroundApp new start.

	"Run sync and async tests of all imported Test* classes and log results."
	TestPlayground all.
	await self testGui.
!
async testGui
	"Click evaluate the expression '10 factorial' and check for result '3628800'."

	await self testExpression: '6 factorial' result: '720'.
	await self testExpression: '1 + 2' result: '3'.
	await self stop.
!
async testExpression: expression result: result
	playgroundApp expressionTextArea value: expression.
	playgroundApp resultTextArea value: ''.

	playgroundApp evaluateButton click.
	await Timer timeout: 1000.
	self assert: [ playgroundApp resultTextArea value = result ].
!
async stop
	await Timer timeout: 1000.
	playgroundApp stop.
!
