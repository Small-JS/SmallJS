CLASS TestMyNwApp EXTENDS Object MODULE TestMyNwApp CLASSVARS '' VARS 'app'

async test: aApp
	app := aApp.

	"Refer to one test class in a module to force importing all classes of that module."
	TestNwApp.

	"Run sync and async tests of all imported Test* classes and log results."

	await Test all.
	await TestMyNwMenu new test: app.
	"TestMyWindow closes the window as the last test."
	await TestMyNwWindow new test: app.
!
