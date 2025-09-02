CLASS TestProcess EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

testArgv
	self assert: [ Process argv length >= 2 ].
	self assert: [ Process argv first includes: 'node' ].
!
testEnv
	| var data |
	var := 'SMALLJS_TEMP'.
	data := 'EnvData'.

	Process envAt: var put: data.
	self assert: [ ( Process envAt: var ) = data ].
	self assert: [ ( Process env atJsProperty: var ) = data ].

	Process envDeleteAt: var.
	self assert: [ ( Process envAt: var ) isNil ].
!
testDirectory
	self assert: [ ( Process cwd includes: '/' ) | ( Process cwd includes: '\\' ) ].
!
testPlatform
	| platforms |
	platforms := #( 'aix' 'darwin' 'freebsd' 'linux' 'openbsd' 'sunos' 'win32' 'android' ).
	self assert: [ platforms includes: Process platform ].

	Process isWindows ifTrue: [
		self assert: [ Process platform = 'win32' ] ].
!
