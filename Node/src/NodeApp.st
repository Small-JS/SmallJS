CLASS NodeApp EXTENDS Object MODULE NodeApp CLASSVARS '' VARS ''
	"This app is run after the ST 'image' is fully compiled."

CLASSMETHODS

METHODS

start
	"These class references are needed to force importing their unit test modules."
	TestObject.
	TestExpress.
	TestHash.
	TestProcess.

	TestPostgresDatabase.

	Object myTest.
	Test all.
!
