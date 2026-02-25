CLASS TestMyElectronApp EXTENDS Object MODULE TestMyElectronMain CLASSVARS ''
	VARS 'myElectronApp'

"Test ShopServer units and API.
 This class is not a subclass of Test so is not called automatically with Test all."

start
	myElectronApp := MyElectronApp new start.

	"Run sync and async unit tests of all imported Test* classes and log results."
	TestWebPreferences all.
!
