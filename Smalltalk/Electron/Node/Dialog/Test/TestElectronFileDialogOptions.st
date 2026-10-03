CLASS TestElectronFileDialogOptions EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| options |

	options := ElectronFileDialogOptions new.
	self assert: [ options title isNil ].
	self assert: [ options defaultPath isNil ].
	self assert: [ options buttonLabel isNil ].
	self assert: [ options filters isNil ].
	self assert: [ options properties isNil ].
!
testProperties
	| options |

	options := ElectronFileDialogOptions new.
	options title: 'Title'; defaultPath: '/temp'; buttonLabel: 'Choose';
		properties: #( 'openFile' 'multiSelections' ).
	self assert: [ options title = 'Title' ].
	self assert: [ options defaultPath = '/temp' ].
	self assert: [ options buttonLabel = 'Choose' ].
	self assert: [ options properties = #( 'openFile' 'multiSelections' ) ].
!
testFilters
	| options images text filters |

	images := ElectronFileFilter name: 'Images' extensions: #( 'png' 'jpg' ).
	text := ElectronFileFilter name: 'Text' extensions: #( 'txt' ).

	options := ElectronFileDialogOptions new.
	options filters: ( Array with: images ).
	filters := options filters.
	self assert: [ filters length = 1 ].
	self assert: [ filters first class = ElectronFileFilter ].
	self assert: [ filters first = images ].

	options addFilter: text.
	filters := options filters.
	self assert: [ filters length = 2 ].
	self assert: [ ( filters at: 1 ) name = 'Text' ].

	"Add to unset filters."
	options := ElectronFileDialogOptions new.
	options addFilter: text.
	self assert: [ options filters length = 1 ].

	"Filters must be a plain JS array of plain objects, as expected by Electron."
	self assert: [ ( String fromJs: ( INLINE 'JSON.stringify( options.js.filters )' ) ) = '[{"name":"Text","extensions":["txt"]}]' ].
!
