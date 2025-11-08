CLASS TestCounterUsingMithrilApp EXTENDS Object MODULE TestCounterUsingMithrilApp CLASSVARS '' VARS 'counterUsingMithrilApp'

"Test CounterUsingMithrilApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async test: aCounterUsingMithrilApp
	counterUsingMithrilApp := aCounterUsingMithrilApp.

	"Refer to one test class in a module to force importing all classes of that module."
	TestCounter.

	"Run sync and async tests of all imported Test* classes and log results."
	await Test all.
	await self testGui.
!
async testGui
	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly.
	 Exit if all tests succeed."

	await self testButton: counterUsingMithrilApp incrementButton result: '1'.
	await self testButton: counterUsingMithrilApp incrementButton result: '2'.
	await self testButton: counterUsingMithrilApp resetButton  result: '0'.

	await Timer timeout: 500.
	counterUsingMithrilApp stop.
!
async testButton: button result: result
	"Press argument button and check result in counter label."
	button click.
	await Timer timeout: 500.
	self assert: [ counterUsingMithrilApp counterSpan textContent = result ].
!
