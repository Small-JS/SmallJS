CLASS MyBrowserApp EXTENDS BrowserApp MODULE BrowserApp CLASSVARS '' VARS ''

CLASSMETHODS

METHODS

start
	"Always run tests, its the main goal of this app."
	self runTests.

	self testMode ifTrue: [
		Timer timeout: 4000 then: [
			self stop ] ].
!
runTests
	Object myTest.

	"These test class references are needed to force importing of their modules."
	TestObject.
	TestDocument.

	Test all.

	"Check test repeatability."
	"Test all."
!
