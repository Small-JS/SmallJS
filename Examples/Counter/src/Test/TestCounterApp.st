CLASS TestCounterApp EXTENDS Object MODULE TestCounterClient CLASSVARS '' VARS 'counterApp'

"Test CounterApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aCounterApp
	counterApp := aCounterApp.

	"Refer to one test class in a module to force importing all classes of that module."
	TestCounter.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly.
	 Exit if all tests succeed."

	self testButton: counterApp incrementButton result: '1' then: [
		self testButton: counterApp incrementButton result: '2' then: [
			self testButton: counterApp resetButton  result: '0' then: [
				Timer timeout: 500 then: [ counterApp stop ] ] ] ].
!
testButton: button result: result then: block
	"Press argument button and check result in counter label."
	button click.
	Timer timeout: 500 then: [
		self assert: [ counterApp counterLabel textContent = result ].
		block value ].
!
