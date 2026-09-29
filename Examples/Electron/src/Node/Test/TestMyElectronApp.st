CLASS TestMyElectronApp EXTENDS Object MODULE TestMyElectronMain CLASSVARS ''
	VARS 'myElectronApp'

"Test ShopServer units and API.
 This class is not a subclass of Test so is not called automatically with Test all."

start
	myElectronApp := MyElectronApp new start.

	"For import of ElectromMain module."
	TestElectronApp.

	"The method 'all' will test all imported test classes, so only need to run it once."
	Test all.
!
