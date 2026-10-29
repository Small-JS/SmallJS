CLASS TestQGroupBox EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| groupBox |
	groupBox := QGroupBox new.
	self assert: [ groupBox jsClassName = 'QGroupBox' ].
	self assert: [ groupBox title = '' ].
	self assert: [ groupBox isFlat not ].

	groupBox setTitle: 'My Group'.
	self assert: [ groupBox title = 'My Group' ].
	groupBox setAlignment: QLayout alignRight.
	self assert: [ groupBox alignment = QLayout alignRight ].
	groupBox setFlat: true.
	self assert: [ groupBox isFlat ].
!
testChecking
	| groupBox count |
	groupBox := QGroupBox new.
	self assert: [ groupBox isCheckable not ].
	self assert: [ groupBox isChecked not ].

	"Checking a group box that is not checkable has no effect."
	groupBox setChecked: true.
	self assert: [ groupBox isChecked not ].

	"A group box is checked when it becomes checkable."
	groupBox setCheckable: true.
	self assert: [ groupBox isCheckable ].
	self assert: [ groupBox isChecked ].

	count := 0.
	groupBox onToggle: [ count := count + 1 ].
	groupBox setChecked: false.
	self assert: [ groupBox isChecked not ].
	self assert: [ count = 1 ].
!
