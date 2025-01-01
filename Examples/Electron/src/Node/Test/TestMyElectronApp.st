CLASS TestMyElectronApp EXTENDS Object MODULE TestMyElectronApp CLASSVARS '' VARS 'app'

"Test ShopServer units and API.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aApp
	app := aApp.

	"Force import of module TestElectronMain"
	TestWebPreferences.

	"Run sync and async unit tests of all imported Test* classes and log results."
	Test all.
!
