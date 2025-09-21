CLASS MyNwApp EXTENDS NwApp MODULE MyNwApp CLASSVARS ''
	VARS 'body fileInput fileOpenButton
		fileOutputCell fileTextAreaTemplate fileTextArea
		menuBar contextMenu
		database'

"Running"

start
	self bindElements.
	self setMenu.
	self openDatabase.

	self testMode ifTrue: [
		TestMyNwApp new test: self ].
!

"HTML Elements"

bindElements
	"Bind HTML elements to variables, set defaults, set event listeners."

	body := Document default body.

	fileInput := Document default getElementById: 'fileInput' class: HtmlInputElement.
	fileInput value: 'poem.txt'.

	fileOpenButton := Document default getElementById: 'fileOpenButton' class: HtmlButtonElement.
	fileOpenButton onClick: [ self openFile ].

	fileOutputCell := Document default getElementById: 'fileOutputCell' class: HtmlTableCellElement.
	fileTextAreaTemplate := Document default getElementById: 'fileTextAreaTemplate' class: HtmlTemplateElement.
!

"Menus"

setMenu
	self setMenuBar.
	self setContextMenu.
!
setMenuBar
	"The menus are built from the bottom up."

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

"Color changes"

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

"File display"

openFile
	| fileName text |
	fileName := fileInput value.
	text := ( Fs existsSync: fileName )
		ifTrue: [ ( Fs readFileSync: fileName ) toString ]
		ifFalse: [ 'File not found: ', fileName ].
	self displayFileText: text.
!
displayFileText: text
	self createFileTextArea.
	fileTextArea value: text.
!
createFileTextArea
	"Only create it once"
	fileTextArea ifNotNil: [ ^ nil ].

	fileTextArea := fileTextAreaTemplate cloneContent children first.
	fileOutputCell replaceChildren: fileTextArea.
!

"Database"

openDatabase
	"This only creates an in-memory SQLite database,
	 to verify the database module can be used from NWjs"

	"Importing non-built-in npm packages does not work yet."
	"Console log: 'Opening database'."
	"MariadbDatabase."
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
fileOpenButton
	^ fileOpenButton.
!
fileTextArea
	^ fileTextArea.
!

