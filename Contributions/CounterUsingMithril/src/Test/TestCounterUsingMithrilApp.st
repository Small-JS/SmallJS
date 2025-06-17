CLASS TestCounterUsingMithrilApp EXTENDS Object MODULE TestCounterUsingMithrilApp CLASSVARS '' VARS 'counterUsingMithrilApp'

"Test CounterUsingMithrilApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aCounterUsingMithrilApp
	counterUsingMithrilApp := aCounterUsingMithrilApp.

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

	self testButton: counterUsingMithrilApp incrementButton result: '1' then: [
		self testButton: counterUsingMithrilApp incrementButton result: '2' then: [
			self testButton: counterUsingMithrilApp resetButton  result: '0' then: [
				Timer timeout: 500 then: [ counterUsingMithrilApp stop ] ] ] ].
!
testButton: button result: result then: block
	"Press argument button and check result in counter label."
	button click.
	Timer timeout: 500 then: [
		self assert: [ counterUsingMithrilApp counterSpan textContent = result ].
		block value ].
!
