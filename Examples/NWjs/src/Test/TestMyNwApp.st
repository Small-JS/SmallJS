CLASS TestMyNwApp EXTENDS Object MODULE TestMyNwApp CLASSVARS '' VARS 'app'

test: aApp
	app := aApp.

	"Refer to one test class in a module to force importing all classes of that module."
	TestNwApp.

	"Run sync and async tests of all imported Test* classes and log results."

	Test allThen: [
		self testGui ].
!
testGui
	"These tests run async in parallel"
	TestMyNwMenu new test: app.
	TestMyNwWindow new test: app.
	"TestMyWindow closes the window as the last test."
!
