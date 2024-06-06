CLASS TestMyBrowserApp EXTENDS Object MODULE TestBrowserApp CLASSVARS '' VARS 'myBrowserApp'

"Test MyBrowserApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aMyBrowserApp
	myBrowserApp := aMyBrowserApp.

	"Run sync and async tests of all imported Test* classes and log results."
	Timer timeout: 1000 then: [    "Wait for app components to load"
		self testUnitsThen: [
			self testGuiThen: [
				self stop ] ] ].
!
testUnitsThen: block
	"This test method is compiled first.
	 Can be used for testing the compiler."
	Object myTest.

	"Refer to one unit test class per module to force importing all classes of that module."
	TestObject.     "Core"
	TestDocument.   "Browser"

	Test allThen: [
		block value ].

	"Replace above with this to tests twice checking repeatability."
	"Test allThen: [
		Test allThen: [
			block value ]."
!
testGuiThen: block
	"Currently all GUI tests are done through the unit tests of this project."

	block value.
!
stop
	Timer timeout: 2000 then: [
		myBrowserApp stop ].
!

"Accessing"

myBrowserApp
	^ myBrowserApp.
!
