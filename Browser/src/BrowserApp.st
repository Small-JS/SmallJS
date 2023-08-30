CLASS BrowserApp EXTENDS Object MODULE BrowserApp CLASSVARS '' VARS ''

CLASSMETHODS

METHODS

start
	Object myTest.

	"These test class references are needed to force importing of their modules."
	TestObject.
	TestDocument.

	Test all.

	"Check test repeatability:"
	"Test all."
!
