CLASS TestQShortcut EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| widget shortcut |
	widget := QWidget new.
	shortcut := QShortcut new: widget.
	self assert: [ shortcut jsClassName = 'QShortcut' ].
	self assert: [ shortcut parent = widget ].
	self assert: [ shortcut key isEmpty ].

	shortcut setKey: ( QKeySequence new: 'Ctrl+K' ).
	self assert: [ shortcut key = ( QKeySequence new: 'Ctrl+K' ) ].

	self assert: [ shortcut context = QAction windowShortcut ].
	shortcut setContext: QAction widgetShortcut.
	self assert: [ shortcut context = QAction widgetShortcut ].

	self assert: [ shortcut isEnabled ].
	shortcut setEnabled: false.
	self assert: [ shortcut isEnabled not ].

	self assert: [ shortcut autoRepeat ].
	shortcut setAutoRepeat: false.
	self assert: [ shortcut autoRepeat not ].

	"The events are fired by the user pressing keys only."
	shortcut onActivate: [ self assert: [ false ] ].
	shortcut onActivateAmbiguously: [ self assert: [ false ] ].
!
