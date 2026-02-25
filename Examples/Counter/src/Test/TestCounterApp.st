CLASS TestCounterApp EXTENDS Object MODULE TestCounterApp CLASSVARS ''
	VARS 'counterApp'

"Test CounterApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	counterApp := CounterApp new start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestCounter all.
	await self testGui.
!
async testGui
	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly.
	 Exit if all tests succeed."

	await self testButton: counterApp incrementButton result: '1'.
	await self testButton: counterApp incrementButton result: '2'.
	await self testButton: counterApp resetButton  result: '0'.

	await Timer timeout: 500.
	counterApp stop.
!
async testButton: button result: result
	"Press argument button and check result in counter label."
	button click.
	await Timer timeout: 500.
	self assert: [ counterApp counterSpan textContent = result ].
!
