CLASS TestQFrame EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| frame |
	frame := QFrame new.
	self assert: [ frame jsClassName = 'QFrame' ].
	self assert: [ frame frameShape = QFrame noFrame ].
	self assert: [ frame frameShadow = QFrame plain ].
	self assert: [ frame frameWidth = 0 ].

	frame setFrameShape: QFrame box.
	frame setFrameShadow: QFrame sunken.
	self assert: [ frame frameShape = QFrame box ].
	self assert: [ frame frameShadow = QFrame sunken ].

	frame setLineWidth: 3.
	frame setMidLineWidth: 2.
	self assert: [ frame lineWidth = 3 ].
	self assert: [ frame midLineWidth = 2 ].
	"A sunken box has 2 lines and a mid line."
	self assert: [ frame frameWidth = 8 ].
!
testLine
	| frame |
	frame := QFrame new.
	frame setFrameShape: QFrame hLine.
	self assert: [ frame frameShape = QFrame hLine ].
	frame setFrameShape: QFrame vLine.
	self assert: [ frame frameShape = QFrame vLine ].
!
