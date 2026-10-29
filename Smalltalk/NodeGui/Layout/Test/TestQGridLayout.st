CLASS TestQGridLayout EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| layout |
	layout := QGridLayout new.
	self assert: [ layout class = QGridLayout ].

	layout addWidget: QLabel new row: 0 column: 0.
	layout addWidget: QLabel new row: 1 column: 2 align: QLayout alignLeft.
	self assert: [ layout rowCount = 2 ].
	self assert: [ layout columnCount = 3 ].
!
testColumnMinimumWidth
	| layout |
	layout := QGridLayout new.
	self assert: [ ( layout columnMinimumWidth: 0 ) = 0 ].
	layout setColumnMinimumWidth: 0 to: 100.
	self assert: [ ( layout columnMinimumWidth: 0 ) = 100 ].
!
