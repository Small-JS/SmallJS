CLASS TestQLineEdit EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| lineEdit count |
	lineEdit := QLineEdit new.
	self assert: [ lineEdit jsClassName = 'QLineEdit' ].
	self assert: [ lineEdit text = '' ].
	count := 0.
	lineEdit onTextChange: [ count := count + 1 ].

	lineEdit setText: 'Hello'.
	self assert: [ lineEdit text = 'Hello' ].
	self assert: [ lineEdit cursorPosition = 5 ].
	lineEdit insert: ' World'.
	self assert: [ lineEdit text = 'Hello World' ].
	self assert: [ count = 2 ].
	lineEdit clear.
	self assert: [ lineEdit text = '' ].
	self assert: [ count = 3 ].

	lineEdit setPlaceholderText: 'Type here'.
	self assert: [ lineEdit placeholderText = 'Type here' ].
!
testOptions
	| lineEdit |
	lineEdit := QLineEdit new.
	self assert: [ lineEdit maxLength = 32767 ].
	lineEdit setMaxLength: 3.
	lineEdit setText: 'Hello'.
	self assert: [ lineEdit text = 'Hel' ].

	self assert: [ lineEdit isReadOnly not ].
	lineEdit setReadOnly: true.
	self assert: [ lineEdit isReadOnly ].

	lineEdit setAlignment: QLayout alignRight.
	self assert: [ ( lineEdit alignment & QLayout alignRight ) = QLayout alignRight ].
	self assert: [ lineEdit isClearButtonEnabled not ].
	lineEdit setClearButtonEnabled: true.
	self assert: [ lineEdit isClearButtonEnabled ].
	self assert: [ lineEdit hasFrame ].
	lineEdit setFrame: false.
	self assert: [ lineEdit hasFrame not ].
	self assert: [ lineEdit isModified not ].
	lineEdit setModified: true.
	self assert: [ lineEdit isModified ].
!
testEchoMode
	| lineEdit |
	lineEdit := QLineEdit new setText: 'secret'.
	self assert: [ lineEdit echoMode = QLineEdit normal ].
	self assert: [ lineEdit displayText = 'secret' ].
	lineEdit setEchoMode: QLineEdit password.
	self assert: [ lineEdit echoMode = QLineEdit password ].
	self assert: [ lineEdit text = 'secret' ].
	self assert: [ lineEdit displayText ~= 'secret' ].
	lineEdit setEchoMode: QLineEdit noEcho.
	self assert: [ lineEdit displayText = '' ].
!
testInputMask
	| lineEdit |
	lineEdit := QLineEdit new.
	"In a mask, 9 is a required digit, 0 an optional one."
	lineEdit setInputMask: '999'.
	self assert: [ lineEdit inputMask = '999' ].
	lineEdit setText: '12'.
	self assert: [ lineEdit hasAcceptableInput not ].
	lineEdit setText: '123'.
	self assert: [ lineEdit hasAcceptableInput ].
!
testEditing
	| lineEdit |
	lineEdit := QLineEdit new setText: 'Hello'.
	lineEdit setCursorPosition: 1.
	self assert: [ lineEdit cursorPosition = 1 ].
	lineEdit deleteCharacter.
	self assert: [ lineEdit text = 'Hllo' ].
	lineEdit backspace.
	self assert: [ lineEdit text = 'llo' ].

	lineEdit undo.
	self assert: [ lineEdit text = 'Hllo' ].
	self assert: [ lineEdit isRedoAvailable ].
	lineEdit redo.
	self assert: [ lineEdit text = 'llo' ].
	self assert: [ lineEdit isUndoAvailable ].
!
testSelection
	| lineEdit count |
	lineEdit := QLineEdit new setText: 'Hello World'.
	count := 0.
	lineEdit onSelectionChange: [ count := count + 1 ].
	self assert: [ lineEdit hasSelectedText not ].
	self assert: [ lineEdit selectionStart = -1 ].

	lineEdit setSelection: 6 length: 5.
	self assert: [ lineEdit selectedText = 'World' ].
	self assert: [ lineEdit selectionStart = 6 ].
	lineEdit selectAll.
	self assert: [ lineEdit selectedText = 'Hello World' ].
	lineEdit deselect.
	self assert: [ lineEdit hasSelectedText not ].
	self assert: [ count = 3 ].
!
testEvents
	"The other events are fired by user interaction only.
	 The clipboard methods are not tested, to not change the clipboard of the user."
	| lineEdit |
	lineEdit := QLineEdit new.
	lineEdit onTextEdit: [ self assert: [ false ] ].
	lineEdit onReturnPress: [ self assert: [ false ] ].
	lineEdit onEditFinish: [ self assert: [ false ] ].
	lineEdit onInputReject: [ self assert: [ false ] ].
!
