CLASS TestQStackedWidget EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| stack label1 label2 count |
	stack := QStackedWidget new.
	self assert: [ stack jsClassName = 'QStackedWidget' ].
	self assert: [ stack count = 0 ].
	self assert: [ stack currentIndex = -1 ].

	label1 := QLabel new.
	label2 := QLabel new.
	stack addWidget: label1.
	stack addWidget: label2.
	self assert: [ stack count = 2 ].
	self assert: [ stack currentIndex = 0 ].

	count := 0.
	stack onCurrentChange: [ count := count + 1 ].
	stack setCurrentIndex: 1.
	self assert: [ stack currentIndex = 1 ].
	self assert: [ count = 1 ].
	stack setCurrentWidget: label1.
	self assert: [ stack currentIndex = 0 ].
	self assert: [ count = 2 ].

	stack removeWidget: label1.
	self assert: [ stack count = 1 ].
!
