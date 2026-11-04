CLASS TestMyElectronView EXTENDS Object MODULE TestMyElectronRenderer CLASSVARS ''
	VARS 'myElectronView'

"Test the ElectronView library units, and MyElectronView GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	"For import of TestElectronRenderer module."
	TestElectronView.

	"The method 'all' will test all imported test classes, so only need to run it once."
	await Test all.

	myElectronView := MyElectronView new start.
	"The GUI tests change the page and quit the app, so first wait for the app tests to finish."
	await self waitForMainTests: 600.
	Console log: 'TestMyElectronView: running GUI tests.'.

	"Click on the buttons 'Color Text', 'Modify Title' and 'Ping'
	 and check for the expected results in span elements."

	await self testButton: myElectronView colorTextButton
		resultSpan: myElectronView colorTextResultSpan
		result: 'Colored text'.

	await self testButton: myElectronView setTitleButton
		resultSpan: myElectronView setTitleResultSpan
		result: 'Title modified'.
	"The window title itself is checked in TestMyElectronApp>>testSetTitle, because the page cannot read it."

	await self testButton: myElectronView pingButton
		resultSpan: myElectronView pingResultSpan
		result: 'Pong'.

	await Timer timeout: 1000.

	myElectronView quit.
!
async waitForMainTests: tries
	"TestMyElectronApp sets this flag in the page when its tests are done.
	 Continues after the tries are used up, so the app still quits if those tests hang."
	( ( Boolean fromJs: INLINE 'window.mainTestsDone === true' ) or: [ tries <= 0 ] ) ifTrue: [ ^ self ].
	await Timer timeout: 100.
	await self waitForMainTests: tries - 1.
!
async testButton: button resultSpan: resultSpan result: result
	"Press argument button and check result text result span."
	button click.
	await Timer timeout: 1000.
	self assert: [ resultSpan textContent = result ].
!
