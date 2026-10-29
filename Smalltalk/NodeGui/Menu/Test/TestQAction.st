CLASS TestQAction EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| action |
	action := QAction new.
	self assert: [ action jsClassName = 'QAction' ].
	self assert: [ action text = '' ].

	action setText: 'My Action'.
	self assert: [ action text = 'My Action' ].
	"By default the tool tip is the text."
	self assert: [ action toolTip = 'My Action' ].
	action setToolTip: 'My Tip'.
	self assert: [ action toolTip = 'My Tip' ].

	self assert: [ action isEnabled ].
	action setEnabled: false.
	self assert: [ action isEnabled not ].

	self assert: [ action isSeparator not ].
	action setSeparator: true.
	self assert: [ action isSeparator ].

	action setIcon: QIcon new.
	action setMenu: QMenu new.
!
testChecking
	"NodeGui cannot trigger an action, but setting the checked state fires events."
	| action toggleCount changeCount |
	action := QAction new.
	toggleCount := 0.
	changeCount := 0.
	action onToggle: [ toggleCount := toggleCount + 1 ].
	action onChange: [ changeCount := changeCount + 1 ].
	action onTrigger: [ self assert: [ false ] ].
	action onHover: [ self assert: [ false ] ].
	self assert: [ action isCheckable not ].

	"Checking an action that is not checkable has no effect, until it becomes checkable."
	action setChecked: true.
	self assert: [ action isChecked not ].
	self assert: [ toggleCount = 0 ].
	action setCheckable: true.
	self assert: [ action isCheckable ].
	self assert: [ action isChecked ].
	self assert: [ toggleCount = 1 ].
	self assert: [ changeCount = 1 ].

	action setChecked: false.
	self assert: [ action isChecked not ].
	self assert: [ toggleCount = 2 ].
	self assert: [ changeCount = 2 ].
!
testShortcut
	| action |
	action := QAction new.
	self assert: [ action shortcut isEmpty ].
	self assert: [ action shortcutContext = QAction windowShortcut ].

	action setShortcut: ( QKeySequence new: 'Ctrl+S' ).
	self assert: [ action shortcut = ( QKeySequence new: 'Ctrl+S' ) ].
	action setShortcutContext: QAction applicationShortcut.
	self assert: [ action shortcutContext = QAction applicationShortcut ].
!
testData
	| action |
	action := QAction new.
	action setData: ( QVariant new: 'My Data' ).
	self assert: [ action data toString = 'My Data' ].
!
