CLASS TestQStackedLayout EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"The layouts are set on a widget that is not shown,
 else the current widget of the layout is shown as a separate window."

test
	| layout label1 label2 label3 |
	layout := QStackedLayout new.
	QWidget new setLayout: layout.
	self assert: [ layout class = QStackedLayout ].
	self assert: [ layout count = 0 ].
	self assert: [ layout currentIndex = -1 ].
	self assert: [ layout currentWidget isNil ].

	label1 := QLabel new.
	label2 := QLabel new.
	label3 := QLabel new.
	layout addWidget: label1.
	layout addWidget: label3.
	layout insertWidget: label2 at: 1.
	self assert: [ layout count = 3 ].
	self assert: [ ( layout indexOf: label2 ) = 1 ].
	self assert: [ ( layout widget: 2 ) = label3 ].
	self assert: [ ( layout widget: 3 ) isNil ].
	"The first widget added becomes the current widget."
	self assert: [ layout currentIndex = 0 ].
	self assert: [ layout currentWidget = label1 ].

	layout removeWidget: label1.
	self assert: [ layout count = 2 ].
	self assert: [ ( layout indexOf: label1 ) = -1 ].
!
testCurrent
	| layout label1 label2 count |
	layout := QStackedLayout new.
	QWidget new setLayout: layout.
	label1 := QLabel new.
	label2 := QLabel new.
	layout addWidget: label1.
	layout addWidget: label2.
	count := 0.
	layout onCurrentChange: [ count := count + 1 ].

	layout setCurrentIndex: 1.
	self assert: [ layout currentWidget = label2 ].
	self assert: [ count = 1 ].

	layout setCurrentWidget: label1.
	self assert: [ layout currentIndex = 0 ].
	self assert: [ count = 2 ].
!
testStackingMode
	| layout |
	layout := QStackedLayout new.
	QWidget new setLayout: layout.
	self assert: [ layout stackingMode = QStackedLayout stackOne ].
	layout setStackingMode: QStackedLayout stackAll.
	self assert: [ layout stackingMode = QStackedLayout stackAll ].
!
