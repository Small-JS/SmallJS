CLASS TestElectronShell EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"Most shell methods open external applications, so these cannot be tested automatically.
 The async methods are tested live in the test app."

test
	| shell |

	shell := ElectronShell new.
	self assert: [ shell class = ElectronShell ].
	self assert: [ shell = ElectronShell new ].
	#( 'openExternal' 'openPath' 'showItemInFolder' 'trashItem' 'beep' ) do: [ :name |
		self assert: [ ( String fromJs: ( INLINE 'typeof shell.js[ name.js ]' ) ) = 'function' ] ].
!
