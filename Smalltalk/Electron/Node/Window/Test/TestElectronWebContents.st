CLASS TestElectronWebContents EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"Tests that do not need an actual window, which can only be created after the app is ready.
 The instance methods are tested live in the test app."

testClassMethods
	self assert: [ ElectronWebContents all class = Array ].
	self assert: [ ElectronWebContents all every: [ :webContents |
		webContents class = ElectronWebContents ] ].
	self assert: [ ( ElectronWebContents fromId: 999999 ) isNil ].
	self assert: [ ElectronWebContents focused isNil or: [
		ElectronWebContents focused class = ElectronWebContents ] ].
!
