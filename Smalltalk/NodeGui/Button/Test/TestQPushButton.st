CLASS TestQPushButton EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"Also tests QAbstractButton"

test
	| button |
	button := QPushButton new.

	button setText: 'My Button'.
	self assert: [ button text = 'My Button' ].

	button onClick: [ self buttonClicked ].
	button click.
!
buttonClicked
	self assert: [ true ].
!
testIcon
	| button |
	button := QPushButton new.
	self assert: [ button icon class = QIcon ].
	button setIcon: ( QIcon new: 'missing.ico' ).
	self assert: [ button icon class = QIcon ].
!
testChecking
	| button toggleCount |
	button := QPushButton new.
	toggleCount := 0.
	button onToggle: [ toggleCount := toggleCount + 1 ].

	"A button that is not checkable cannot be checked."
	self assert: [ button isCheckable not ].
	button setChecked: true.
	self assert: [ button isChecked not ].
	button toggle.
	self assert: [ button isChecked not ].
	self assert: [ toggleCount = 0 ].

	button setCheckable: true.
	self assert: [ button isCheckable ].
	button setChecked: true.
	self assert: [ button isChecked ].
	button toggle.
	self assert: [ button isChecked not ].
	button click.
	self assert: [ button isChecked ].
	self assert: [ toggleCount = 3 ].
!
testAutoExclusive
	| parent button1 button2 |
	parent := QWidget new.
	button1 := QPushButton new.
	button2 := QPushButton new.
	button1 setParent: parent; setCheckable: true.
	button2 setParent: parent; setCheckable: true.

	self assert: [ button1 autoExclusive not ].
	button1 setChecked: true.
	button2 setChecked: true.
	self assert: [ button1 isChecked & button2 isChecked ].

	"Exclusivity is applied when a button gets checked."
	button1 setChecked: false; setAutoExclusive: true.
	button2 setChecked: false; setAutoExclusive: true.
	self assert: [ button1 autoExclusive ].
	button1 setChecked: true.
	self assert: [ button1 isChecked & button2 isChecked not ].
	button2 setChecked: true.
	self assert: [ button1 isChecked not & button2 isChecked ].
!
testDown
	| button |
	button := QPushButton new.
	self assert: [ button isDown not ].
	button setDown: true.
	self assert: [ button isDown ].
	button setDown: false.
	self assert: [ button isDown not ].
!
testAutoRepeat
	| button |
	button := QPushButton new.
	self assert: [ button autoRepeat not ].
	button setAutoRepeat: true.
	self assert: [ button autoRepeat ].

	button setAutoRepeatDelay: 500.
	self assert: [ button autoRepeatDelay = 500 ].
	button setAutoRepeatInterval: 50.
	self assert: [ button autoRepeatInterval = 50 ].
!
async testAnimateClick
	"The click is emitted after the button has been shown pressed for a short time."
	| button clickCount |
	button := QPushButton new.
	clickCount := 0.
	button onClick: [ clickCount := clickCount + 1 ].

	button animateClick.
	self assert: [ clickCount = 0 ].
	await Timer timeout: 500.
	self assert: [ clickCount = 1 ].
!
testDefault
	| button |
	button := QPushButton new.
	self assert: [ button isDefault not ].
	button setDefault: true.
	self assert: [ button isDefault ].

	button setAutoDefault: true.
	self assert: [ button autoDefault ].
	button setAutoDefault: false.
	self assert: [ button autoDefault not ].
!
testFlat
	| button |
	button := QPushButton new.
	self assert: [ button isFlat not ].
	button setFlat: true.
	self assert: [ button isFlat ].
!
testMenu
	| button menu |
	button := QPushButton new.
	self assert: [ button menu isNil ].

	menu := QMenu new.
	menu setTitle: 'My Menu'.
	button setMenu: menu.
	self assert: [ button menu = menu ].
	self assert: [ button menu title = 'My Menu' ].
!
