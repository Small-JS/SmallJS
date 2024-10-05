CLASS TestQBoxLayout EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| layout |
	layout := QBoxLayout new: QLayout topToBottom.
	self assert: [ layout class = QBoxLayout ].

	layout addWidget: QLabel new stretch: 0 align: QLayout alignCenter.
	self assert: [ layout count = 1 ].
!
