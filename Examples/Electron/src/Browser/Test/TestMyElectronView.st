CLASS TestMyElectronView EXTENDS Object MODULE TestElectonRenderer CLASSVARS '' VARS 'myElectronView'

"Test MyElectronView units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async test: aMyElectronView
	myElectronView := aMyElectronView.
	await Timer timeout: 2000.
	Console log: 'TestMyElectronView: running GUI tests.'.

	"Click on the buttons 'Color Text', 'Modify Title' and 'Ping'
	 and check for the expected results in span elements."

	await self testButton: myElectronView colorTextButton
		resultSpan: myElectronView colorTextResultSpan
		result: 'Colored text'.

	await self testButton: myElectronView modifyTitleButton
		resultSpan: myElectronView modifyTitleResultSpan
		result: 'Title modified'.

	await self testButton: myElectronView pingButton
		resultSpan: myElectronView pingResultSpan
		result: 'Pong'.

	await Timer timeout: 1000.

	myElectronView quit.
!
async testButton: button resultSpan: resultSpan result: result
	"Press argument button and check result text result span."
	button click.
	await Timer timeout: 1000.
	self assert: [ resultSpan textContent = result ].
!
