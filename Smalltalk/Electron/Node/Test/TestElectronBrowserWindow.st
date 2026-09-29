CLASS TestElectronBrowserWindow EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"Tests that do not need an actual window, which can only be created after the app is ready."

testClassMethods
	self assert: [ ElectronBrowserWindow allWindows class = Array ].
	self assert: [ ElectronBrowserWindow allWindows every: [ :window |
		window class = ElectronBrowserWindow ] ].
	self assert: [ ( ElectronBrowserWindow fromId: 999999 ) isNil ].
	self assert: [ ElectronBrowserWindow focusedWindow isNil or: [
		ElectronBrowserWindow focusedWindow class = ElectronBrowserWindow ] ].
!
testNewBeforeReady
	"Electron does not allow creating windows before the app is ready."
	ElectronApp new isReady ifFalse: [
		self assertError: [ ElectronBrowserWindow new ].
		self assertError: [ ElectronBrowserWindow new: BrowserWindowOptions new ] ].
!
