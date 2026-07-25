CLASS TestCounterApp EXTENDS Object MODULE TestCounterApp CLASSVARS ''
	VARS 'counterApp counterSpan incrementButton resetButton'

"Test CounterApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async startOn: aCounterApp
	counterApp := aCounterApp.
	"Run sync and async tests of all imported Test* classes and log results."
	await TestCounter all.
	await self testGui.
	await self stop.
!
async testGui
	"Wait for the React component to render."
	counterApp := CounterApp new start.
	self bindElements.

	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly."

	await Timer timeout: 500.
	await self testButton: incrementButton result: '1'.
	await self testButton: incrementButton result: '2'.
	await self testButton: resetButton  result: '0'.
!
bindElements
	counterSpan := Document getElementById: 'counterSpan' class: HtmlSpanElement.
	incrementButton := Document getElementById: 'incrementButton' class: HtmlButtonElement.
	resetButton := Document getElementById: 'resetButton' class: HtmlButtonElement.
!
async testButton: button result: result
	"Press argument button and check result in counter label."
	button click.
	await Timer timeout: 500.
	self assert: [ counterSpan textContent = result ].
!
async stop
	await Timer timeout: 500.
	counterApp stop.
!
