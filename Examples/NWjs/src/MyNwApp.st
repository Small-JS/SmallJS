CLASS MyNwApp EXTENDS NwApp MODULE MyNwApp CLASSVARS ''
	VARS 'body menuBar contextMenu'

"Running"

start
	self bindElements.
	self setMenuBar.
	self setContextMenu.

	self testMode ifTrue: [
		TestMyNwApp new test: self ].
!
bindElements
	"Bind HTML elements to variables, set defaults, set event listeners."

	body := Document default body.
!
setMenuBar
	"The menu is built from the bottom up."

	| exitMenuItem fileMenu fileMenuItem |

	exitMenuItem := NwMenuItem new: 'Exit'.
	exitMenuItem icon: 'Images/Exit.png'.
	exitMenuItem click: [ self quit ].

	fileMenu := NwMenu new.
	fileMenu append: exitMenuItem.

	fileMenuItem := NwMenuItem new: 'File'.
	fileMenuItem submenu: fileMenu.

	menuBar := NwMenu newMenuBar.
	menuBar append: fileMenuItem.

	NwWindow get menu: menuBar.
!
setContextMenu
	| item |

	contextMenu := NwMenu new.

	#( 'Red' 'Green' 'Blue' ) do: [ :color |
		item := NwMenuItem checkbox: color.
		item click: [ self onColorMenu: color ].
		contextMenu append: item ].

	body addEventListener: 'contextmenu'
		then: [ :mouseEvent | self onMouseContextMenu: mouseEvent ].
!
onMouseContextMenu: mouseEvent
	mouseEvent preventDefault.
	contextMenu popup: mouseEvent client.
!
onColorMenu: color
	body style setProperty: 'background-color' value: color toLowerCase.

	"Make sure this item is the only item checked.
	 There is no uncheck option, override it."
	contextMenu items do: [ :item |
		item checked: item label = color ].
!

"Accessing (used by tests)"

body
	^ body.
!
menuBar
	^ menuBar.
!
contextMenu
	^ contextMenu.
!

