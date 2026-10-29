CLASS TestQSizePolicy EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| widget |
	self assert: [ QSizePolicy fixed = 0 ].
	self assert: [ QSizePolicy preferred = 5 ].
	self assert: [ QSizePolicy expanding = 7 ].

	"NodeGui cannot read the size policy back, so only check that setting it works."
	widget := QWidget new.
	widget setSizePolicy: QSizePolicy expanding vertical: QSizePolicy fixed.
!
