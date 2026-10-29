CLASS QLineEdit EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A single line text input. Cursor positions and selections count characters, starting at 0.
 Some JS getters read wrong Qt properties, e.g. isReadOnly() reads 'isReadOnly' instead of 'readOnly',
 so those methods read the Qt properties directly."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QLineEdit()'.
!

"Echo mode enums"

normal
	^ 0.
!
noEcho
	"Show nothing, e.g. for a password whose length should be secret."
	^ 1.
!
password
	"Show a mask character for each character."
	^ 2.
!
passwordEchoOnEdit
	"Show the characters while editing, else mask them."
	^ 3.
!

METHODS

"Text"

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	^ String fromJs: INLINE 'this.js.text()'.
!
displayText
	"Answer the text as shown, e.g. masked for a password."
	^ String fromJs: INLINE 'this.js.displayText()'.
!
insert: text
	"Insert text at the cursor, replacing the selection."
	INLINE 'this.js.insert( text.js )'.
!
clear
	INLINE 'this.js.clear()'.
!
setPlaceholderText: text
	"Text shown when the line edit is empty."
	INLINE 'this.js.setPlaceholderText( text.js )'.
!
placeholderText
	^ String fromJs: INLINE 'this.js.placeholderText()'.
!

"Options"

setMaxLength: maxLength
	"The text is truncated to maxLength. The default is 32767."
	INLINE 'this.js.setMaxLength( maxLength.js )'.
!
maxLength
	^ Integer fromJs: INLINE 'this.js.maxLength()'.
!
setReadOnly: readOnly
	INLINE 'this.js.setReadOnly( readOnly.js )'.
!
isReadOnly
	^ Boolean fromJs: INLINE 'this.js.property( "readOnly" ).toBool()'.
!
setEchoMode: echoMode
	"Use the echo mode enums."
	INLINE 'this.js.setEchoMode( echoMode.js )'.
!
echoMode
	^ Integer fromJs: INLINE 'this.js.echoMode()'.
!
setAlignment: alignment
	"Use the QLayout alignment enums."
	INLINE 'this.js.setAlignment( alignment.js )'.
!
alignment
	^ Integer fromJs: INLINE 'this.js.alignment()'.
!
setClearButtonEnabled: enabled
	"Show a button that clears the text, when the text is not empty."
	INLINE 'this.js.setClearButtonEnabled( enabled.js )'.
!
isClearButtonEnabled
	^ Boolean fromJs: INLINE 'this.js.property( "clearButtonEnabled" ).toBool()'.
!
setFrame: frame
	INLINE 'this.js.setFrame( frame.js )'.
!
hasFrame
	^ Boolean fromJs: INLINE 'this.js.property( "frame" ).toBool()'.
!
setInputMask: inputMask
	"Restrict the input with a Qt input mask, e.g. '000.000.000.000' for an IP address."
	INLINE 'this.js.setInputMask( inputMask.js )'.
!
inputMask
	^ String fromJs: INLINE 'this.js.inputMask()'.
!
hasAcceptableInput
	"Answer true if the text matches the input mask."
	^ Boolean fromJs: INLINE 'this.js.property( "acceptableInput" ).toBool()'.
!
setModified: modified
	INLINE 'this.js.setModified( modified.js )'.
!
isModified
	"Answer true if the user edited the text, after it was set with setText:."
	^ Boolean fromJs: INLINE 'this.js.property( "modified" ).toBool()'.
!

"Cursor"

setCursorPosition: position
	INLINE 'this.js.setCursorPosition( position.js )'.
!
cursorPosition
	^ Integer fromJs: INLINE 'this.js.cursorPosition()'.
!
backspace
	"Delete the selection, or the character before the cursor."
	INLINE 'this.js.backspace()'.
!
deleteCharacter
	"Delete the selection, or the character after the cursor.
	 Not named delete, which deletes the C++ object."
	INLINE 'this.js.del()'.
!

"Selection"

selectAll
	INLINE 'this.js.selectAll()'.
!
deselect
	INLINE 'this.js.deselect()'.
!
setSelection: start length: length
	INLINE 'this.js.setSelection( start.js, length.js )'.
!
selectedText
	^ String fromJs: INLINE 'this.js.selectedText()'.
!
hasSelectedText
	^ Boolean fromJs: INLINE 'this.js.hasSelectedText()'.
!
selectionStart
	"Answer -1 if there is no selection."
	^ Integer fromJs: INLINE 'this.js.selectionStart()'.
!

"Undo"

undo
	INLINE 'this.js.undo()'.
!
redo
	INLINE 'this.js.redo()'.
!
isUndoAvailable
	^ Boolean fromJs: INLINE 'this.js.property( "undoAvailable" ).toBool()'.
!
isRedoAvailable
	^ Boolean fromJs: INLINE 'this.js.property( "redoAvailable" ).toBool()'.
!

"Clipboard"

cut
	INLINE 'this.js.cut()'.
!
copy
	INLINE 'this.js.copy()'.
!
paste
	INLINE 'this.js.paste()'.
!

"Events"

onTextChange: block
	"Block is called when the text changes, also when set by code."
	self addEventListener: 'textChanged' then: [ block value ].
!
onTextEdit: block
	"Block is called when the user edits the text."
	self addEventListener: 'textEdited' then: [ block value ].
!
onReturnPress: block
	self addEventListener: 'returnPressed' then: [ block value ].
!
onEditFinish: block
	"Block is called when the user presses Return or the line edit loses focus."
	self addEventListener: 'editingFinished' then: [ block value ].
!
onSelectionChange: block
	self addEventListener: 'selectionChanged' then: [ block value ].
!
onInputReject: block
	"Block is called when the user types a character that does not match the input mask."
	self addEventListener: 'inputRejected' then: [ block value ].
!
