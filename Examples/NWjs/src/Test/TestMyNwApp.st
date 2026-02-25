CLASS TestMyNwApp EXTENDS Object MODULE TestMyNwApp CLASSVARS '' VARS 'myNwApp'

async start
	myNwApp := MyNwApp new start.
	await Timer timeout: 1000.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestNwApp all.

	await TestMyNwMenu new test: myNwApp.
	"TestMyWindow closes the window as the last test."
	await TestMyNwWindow new test: myNwApp.
!
