CLASS TestQSplitter EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| splitter label1 label2 label3 |
	splitter := QSplitter new.
	self assert: [ splitter jsClassName = 'QSplitter' ].
	self assert: [ splitter count = 0 ].
	self assert: [ splitter orientation = QSplitter horizontal ].

	label1 := QLabel new.
	label2 := QLabel new.
	label3 := QLabel new.
	splitter addWidget: label1.
	splitter addWidget: label3.
	splitter insertWidget: label2 at: 1.
	self assert: [ splitter count = 3 ].
	self assert: [ ( splitter indexOf: label2 ) = 1 ].
	self assert: [ ( splitter indexOf: label3 ) = 2 ].
	self assert: [ ( splitter indexOf: QLabel new ) = -1 ].

	splitter setOrientation: QSplitter vertical.
	self assert: [ splitter orientation = QSplitter vertical ].
!
testCollapsing
	| splitter |
	splitter := QSplitter new.
	splitter addWidget: QLabel new.
	self assert: [ splitter childrenCollapsible ].
	self assert: [ splitter isCollapsible: 0 ].

	splitter setCollapsible: 0 to: false.
	self assert: [ ( splitter isCollapsible: 0 ) not ].
!
