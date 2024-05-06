CLASS TestPlaygroundApp EXTENDS Object MODULE TestPlayground CLASSVARS '' VARS 'playgroundApp'

"Test PlaygroundApp units and GUI.
 This class is not a subclass of Test, so it's not called automatically with Test all."

test: aPlaygroundApp
	playgroundApp := aPlaygroundApp.

	"Refer to one test class in a module to force importing all classes of that module."
	TestPlayground.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Click evaluate the expression '10 factorial' and check for result '3628800'."

	self testExpression: '10 factorial' result: '3628800' then: [
		self testExpression: '1 + 2' result: '3' then: [
			self stop ] ].
!
testExpression: expression result: result then: block
	playgroundApp expressionTextArea value: expression.
	playgroundApp resultTextArea value: ''.

	playgroundApp evaluateButton click.
	Timer timeout: 1000 then: [
		self assert: [ playgroundApp resultTextArea value = result ].
		block value ].
!
stop
	Timer timeout: 1000 then: [
		playgroundApp stop ].
!
