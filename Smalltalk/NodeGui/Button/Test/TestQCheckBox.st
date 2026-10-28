CLASS TestQCheckBox EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| checkBox |
	checkBox := QCheckBox new.
	self assert: [ checkBox jsClassName = 'QCheckBox' ].
	self assert: [ checkBox isCheckable ].
	self assert: [ checkBox isChecked not ].
	self assert: [ checkBox checkState = QCheckBox unchecked ].

	checkBox setText: 'My Check Box'.
	self assert: [ checkBox text = 'My Check Box' ].

	checkBox click.
	self assert: [ checkBox isChecked ].
	self assert: [ checkBox checkState = QCheckBox checked ].
	checkBox setCheckState: QCheckBox unchecked.
	self assert: [ checkBox isChecked not ].
!
testTristate
	| checkBox |
	checkBox := QCheckBox new.
	self assert: [ checkBox isTristate not ].
	checkBox setTristate: true.
	self assert: [ checkBox isTristate ].

	checkBox setCheckState: QCheckBox partiallyChecked.
	self assert: [ checkBox checkState = QCheckBox partiallyChecked ].
	"A partially checked check box is also checked."
	self assert: [ checkBox isChecked ].

	"Clicking cycles through the states."
	checkBox click.
	self assert: [ checkBox checkState = QCheckBox checked ].
	checkBox click.
	self assert: [ checkBox checkState = QCheckBox unchecked ].
	checkBox click.
	self assert: [ checkBox checkState = QCheckBox partiallyChecked ].
!
testStateChange
	| checkBox count |
	checkBox := QCheckBox new.
	count := 0.
	checkBox onStateChange: [ count := count + 1 ].

	checkBox setCheckState: QCheckBox checked.
	self assert: [ count = 1 ].
	"Setting the same state does not change it."
	checkBox setCheckState: QCheckBox checked.
	self assert: [ count = 1 ].
	checkBox click.
	self assert: [ count = 2 ].
!
