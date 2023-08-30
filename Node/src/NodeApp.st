CLASS NodeApp EXTENDS Object MODULE NodeApp CLASSVARS '' VARS ''
	"This app is run after the ST 'image' is fully compiled."

CLASSMETHODS

METHODS

references
	"These class references are needed to force importing their unit test modules.
	 This code does not need to be executed."
	TestObject.
	TestExpress.
	TestHash.

	TestPostgresDatabase.
	TestMariadbDatabase.
	TestMysqlDatabase.
!
start
	Object myTest.

	Test all.
!
