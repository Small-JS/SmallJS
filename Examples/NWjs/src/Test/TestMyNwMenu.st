CLASS TestMyNwMenu EXTENDS Object MODULE TestMyNwApp CLASSVARS '' VARS 'app'

"Tests menus in MyNwApp"

async test: aApp
	app := aApp.

	self testMenuBar.
	await self testContextMenu.
!
testMenuBar
	| menuBar fileMenuItem fileMenu exitMenuItem |

	menuBar := app menuBar.
	self assert: [ menuBar class = NwMenu ].
	self assert: [ menuBar type = 'menubar' ].
	self assert: [ menuBar items length = 1 ].

	fileMenuItem := menuBar items first.
	self assert: [ fileMenuItem class = NwMenuItem ].
	self assert: [ fileMenuItem label = 'File' ].

	fileMenu := fileMenuItem submenu.
	self assert: [ fileMenu class = NwMenu ].
	self assert: [ fileMenu type = 'contextmenu' ].
	self assert: [ fileMenu items length = 1 ].

	exitMenuItem := fileMenu items first.
	self assert: [ exitMenuItem class = NwMenuItem ].
	self assert: [ exitMenuItem label = 'Exit' ].
!
async testContextMenu
	| contextMenu redMenuItem greenMenuItem |

	contextMenu := app contextMenu.
	self assert: [ contextMenu class = NwMenu ].
	self assert: [ contextMenu type = 'contextmenu' ].
	self assert: [ contextMenu items length = 3 ].

	redMenuItem := contextMenu items at: 0.
	self assert: [ redMenuItem label = 'Red' ].

	greenMenuItem := contextMenu items at: 1.
	self assert: [ greenMenuItem class = NwMenuItem ].
	self assert: [ greenMenuItem label = 'Green' ].

	redMenuItem click value.
	await Timer timeout: 500.
	self assert: [ ( app body style getPropertyValue: 'background-color' ) = 'red' ].
	self assert: [ ( ( contextMenu items filter: [ :item | item checked ] ) map: [ :item | item label ] ) = #( 'Red' ) ].

	"Choosing another color must uncheck the previous one."
	greenMenuItem click value.
	await Timer timeout: 500.
	self assert: [ ( app body style getPropertyValue: 'background-color' ) = 'green' ].
	self assert: [ ( ( contextMenu items filter: [ :item | item checked ] ) map: [ :item | item label ] ) = #( 'Green' ) ].
!
