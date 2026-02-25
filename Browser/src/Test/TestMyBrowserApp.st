CLASS TestMyBrowserApp EXTENDS Object MODULE TestMyBrowserApp CLASSVARS ''
	VARS 'myBrowserApp'

"Test MyBrowserApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	myBrowserApp := MyBrowserApp new.
	myBrowserApp start.
	"Wait for app components to load"
	await Timer timeout: 2000.

	"Run sync and async tests of all imported Test* classes and log results."
	await self testUnits.
	await self testGui.
	await self stop.
!
async testUnits
	"This test method is compiled first.
	 Can be used for testing the compiler."
	Object myTest.

	"Refer to one unit test class per module to force importing all classes of that module."
	TestObject.     "Core"
	TestDocument.   "Browser"
	TestCrypto.		"Crypto"

	await Test all.

	"Uncomment next line to tests twice, checking repeatability."
	"await Test all."
!
async testGui
	"Currently all GUI tests are done through the unit tests of this project."
!
async stop
	await Timer timeout: 2000.
	myBrowserApp stop.
!

"Accessing"

myBrowserApp
	^ myBrowserApp.
!
