CLASS TestElectronFileFilter EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| filter |

	filter := ElectronFileFilter new.
	self assert: [ filter name isNil ].
	self assert: [ filter extensions isNil ].
!
testProperties
	| filter |

	filter := ElectronFileFilter new.
	filter name: 'Images'; extensions: #( 'png' 'jpg' ).
	self assert: [ filter name = 'Images' ].
	self assert: [ filter extensions = #( 'png' 'jpg' ) ].

	filter := ElectronFileFilter name: 'All files' extensions: #( '*' ).
	self assert: [ filter name = 'All files' ].
	self assert: [ filter extensions = #( '*' ) ].

	"Must be a plain JS object with a string array, as expected by Electron."
	self assert: [ ( String fromJs: ( INLINE 'JSON.stringify( filter.js )' ) ) = '{"name":"All files","extensions":["*"]}' ].
!
