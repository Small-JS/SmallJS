CLASS TestQStatusBar EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| statusBar count |
	statusBar := QStatusBar new.
	self assert: [ statusBar jsClassName = 'QStatusBar' ].
	self assert: [ statusBar currentMessage = '' ].
	count := 0.
	statusBar onMessageChange: [ count := count + 1 ].

	statusBar showMessage: 'My Message'.
	self assert: [ statusBar currentMessage = 'My Message' ].
	self assert: [ count = 1 ].
	statusBar showMessage: 'My Timed Message' timeout: 10000.
	self assert: [ statusBar currentMessage = 'My Timed Message' ].
	statusBar clearMessage.
	self assert: [ statusBar currentMessage = '' ].
	self assert: [ count = 3 ].
!
testWidgets
	| statusBar label1 label2 label3 label4 |
	statusBar := QStatusBar new.
	label1 := QLabel new.
	label2 := QLabel new.
	label3 := QLabel new.
	label4 := QLabel new.

	statusBar addWidget: label2.
	statusBar addWidget: label3 stretch: 1.
	self assert: [ ( statusBar insertWidget: label1 at: 0 ) = 0 ].
	statusBar addPermanentWidget: label4.
	"The permanent widgets come after the 3 normal widgets."
	self assert: [ ( statusBar insertPermanentWidget: QLabel new at: 3 ) = 3 ].
	self assert: [ ( statusBar insertPermanentWidget: QLabel new at: 0 ) = 5 ].
	self assert: [ label1 parent = statusBar ].

	statusBar removeWidget: label1.
!
testSizeGrip
	| statusBar |
	statusBar := QStatusBar new.
	self assert: [ statusBar isSizeGripEnabled ].
	statusBar setSizeGripEnabled: false.
	self assert: [ statusBar isSizeGripEnabled not ].
!
