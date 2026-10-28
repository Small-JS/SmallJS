CLASS TestQRadioButton EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| radioButton |
	radioButton := QRadioButton new.
	self assert: [ radioButton jsClassName = 'QRadioButton' ].
	self assert: [ radioButton isCheckable ].
	self assert: [ radioButton autoExclusive ].
	self assert: [ radioButton isChecked not ].

	radioButton setText: 'My Radio Button'.
	self assert: [ radioButton text = 'My Radio Button' ].

	radioButton click.
	self assert: [ radioButton isChecked ].
	"Clicking a checked auto exclusive radio button does not uncheck it."
	radioButton click.
	self assert: [ radioButton isChecked ].
!
testExclusive
	"Radio buttons with the same parent widget are exclusive."
	| parent radioButton1 radioButton2 otherRadioButton |
	parent := QWidget new.
	radioButton1 := QRadioButton new setParent: parent.
	radioButton2 := QRadioButton new setParent: parent.
	otherRadioButton := QRadioButton new setParent: QWidget new.

	radioButton1 setChecked: true.
	otherRadioButton setChecked: true.
	self assert: [ radioButton1 isChecked & radioButton2 isChecked not ].
	radioButton2 click.
	self assert: [ radioButton1 isChecked not & radioButton2 isChecked ].
	"A radio button with another parent is not affected."
	self assert: [ otherRadioButton isChecked ].
!
