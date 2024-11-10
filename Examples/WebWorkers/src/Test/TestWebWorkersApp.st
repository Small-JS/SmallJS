CLASS TestWebWorkersApp EXTENDS Object MODULE TestWebWorkers CLASSVARS '' VARS 'webWorkersApp'

"Test WebWorkersApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aWebWorkersApp
	webWorkersApp := aWebWorkersApp.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Set work size to 100 and workers to 2.
	 Then press start button and check results in the results table."

	webWorkersApp workSizeInput value: '100'.
	webWorkersApp workersInput value: '2'.

	Timer timeout: 1000 then: [
		webWorkersApp startButton click.
		Timer timeout: 4000 then: [
			self checkResults.
			webWorkersApp stop ] ].
!
checkResults
	"Check if all benchmark results contain numbers."
	| rows |

	rows := webWorkersApp resultsTable tBody rows.
	self assert: [ rows length = 2 ].

	rows do: [ :row |
		self assert: [ ( row cells at: 1 ) textContent toInteger >= 1 ].
		self assert: [ ( row cells at: 1 ) textContent toInteger >= 10 ] ].
!
