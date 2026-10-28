CLASS TestQButtonGroup EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| group button1 button2 |
	group := QButtonGroup new.
	self assert: [ group jsClassName = 'QButtonGroup' ].
	self assert: [ group buttons isEmpty ].
	self assert: [ group exclusive ].

	button1 := QRadioButton new.
	button2 := QRadioButton new.
	group addButton: button1 id: 1.
	group addButton: button2 id: 2.
	self assert: [ group buttons length = 2 ].
	self assert: [ ( group buttons at: 0 ) = button1 ].
	self assert: [ ( group buttons at: 1 ) = button2 ].
	self assert: [ ( group id: button1 ) = 1 ].
	self assert: [ ( group button: 2 ) = button2 ].
	self assert: [ ( group button: 3 ) isNil ].

	"Adding a button again does not add it twice."
	group addButton: button1 id: 1.
	self assert: [ group buttons length = 2 ].

	group setId: button1 id: 10.
	self assert: [ ( group id: button1 ) = 10 ].
	self assert: [ ( group button: 10 ) = button1 ].

	group removeButton: button1.
	self assert: [ group buttons length = 1 ].
	self assert: [ ( group id: button1 ) = -1 ].
!
testAutomaticId
	| group button |
	group := QButtonGroup new.
	button := QPushButton new.
	group addButton: button.
	self assert: [ ( group id: button ) < -1 ].
!
testChecking
	"The buttons have no parent widget, so only the group makes them exclusive."
	| group button1 button2 |
	group := QButtonGroup new.
	button1 := QCheckBox new.
	button2 := QCheckBox new.
	group addButton: button1 id: 1.
	group addButton: button2 id: 2.
	self assert: [ group checkedId = -1 ].
	self assert: [ group checkedButton isNil ].

	button1 click.
	self assert: [ group checkedId = 1 ].
	self assert: [ group checkedButton = button1 ].
	button2 click.
	self assert: [ group checkedId = 2 ].
	self assert: [ group checkedButton = button2 ].
	self assert: [ button1 isChecked not ].

	"Without exclusivity, more buttons can be checked."
	group setExclusive: false.
	self assert: [ group exclusive not ].
	button1 click.
	self assert: [ button1 isChecked & button2 isChecked ].
!
testIdClick
	| group button clickedId |
	group := QButtonGroup new.
	button := QPushButton new.
	group addButton: button id: 5.
	group onIdClick: [ :id | clickedId := id ].

	button click.
	self assert: [ clickedId = 5 ].
!
