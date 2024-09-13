CLASS TestMyElectronView EXTENDS Object MODULE TestElectonRenderer CLASSVARS '' VARS 'myElectronView'

"Test MyElectronView units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aMyElectronView
	myElectronView := aMyElectronView.

	Timer timeout: 2000 then: [
		self testGui ].
!
testGui
	"Click on the buttons 'Color Text', 'Modify Title' and 'Ping'
	 and check for the expected results in span elements."

	self log: 'TestMyElectronView: running GUI tests.'.

	self testButton: myElectronView colorTextButton
		resultSpan: myElectronView colorTextResultSpan
		result: 'Colored text'
		then: [
			self testButton: myElectronView modifyTitleButton
			resultSpan: myElectronView modifyTitleResultSpan
			result: 'Title modified'
			then: [
				self testButton: myElectronView pingButton
				resultSpan: myElectronView pingResultSpan
				result: 'Pong'
				then: [
					Timer timeout: 1000 then: [
						myElectronView quit ] ] ] ].
!
testButton: button resultSpan: resultSpan result: result then: block
	"Press argument button and check result text result span."
	button click.
	Timer timeout: 1000 then: [
		self assert: [ resultSpan textContent = result ].
		block value ].
!
