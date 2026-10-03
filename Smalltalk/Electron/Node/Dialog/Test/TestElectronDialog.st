CLASS TestElectronDialog EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"Showing dialogs needs user interaction, so that is tested live in the test app,
 using a message box that is closed with an AbortSignal."

test
	| dialog |

	dialog := ElectronDialog new.
	self assert: [ dialog class = ElectronDialog ].
	self assert: [ dialog = ElectronDialog new ].
	#( 'showOpenDialogSync' 'showOpenDialog' 'showSaveDialogSync' 'showSaveDialog'
		'showMessageBoxSync' 'showMessageBox' 'showErrorBox' ) do: [ :name |
		self assert: [ ( String fromJs: ( INLINE 'typeof dialog.js[ name.js ]' ) ) = 'function' ] ].
!
testOpenDialogResult
	| result |

	result := ElectronOpenDialogResult fromJs: ( INLINE '{ canceled: false, filePaths: [ "a.txt", "b.txt" ] }' ).
	self assert: [ result canceled not ].
	self assert: [ result filePaths = #( 'a.txt' 'b.txt' ) ].

	result := ElectronOpenDialogResult fromJs: ( INLINE '{ canceled: true, filePaths: [] }' ).
	self assert: [ result canceled ].
	self assert: [ result filePaths isEmpty ].
!
testSaveDialogResult
	| result |

	result := ElectronSaveDialogResult fromJs: ( INLINE '{ canceled: false, filePath: "a.txt" }' ).
	self assert: [ result canceled not ].
	self assert: [ result filePath = 'a.txt' ].

	result := ElectronSaveDialogResult fromJs: ( INLINE '{ canceled: true, filePath: "" }' ).
	self assert: [ result canceled ].
	self assert: [ result filePath isEmpty ].
!
testMessageBoxResult
	| result |

	result := ElectronMessageBoxResult fromJs: ( INLINE '{ response: 1, checkboxChecked: true }' ).
	self assert: [ result response = 1 ].
	self assert: [ result checkboxChecked ].
!
