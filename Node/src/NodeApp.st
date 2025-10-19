CLASS NodeApp EXTENDS Object MODULE NodeApp CLASSVARS '' VARS ''
	"This app is run after the ST 'image' is fully compiled."

CLASSMETHODS

METHODS

start
	"These test class references are needed to force importing their full unit test modules."
	TestObject.
	TestCrypto.
	TestExpress.
	TestProcess.
	TestSqliteDatabaseSync.

	"Test the first method compiled. Used for testing compiler."
	Object myTest.

	"Execute all test* methods on all Test* classes."
	Test all.
!
