CLASS TestQMainWindow EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| window menuBar centralWidget |

	window := QMainWindow new.
	self assert: [ window jsClassName = 'QMainWindow' ].

	menuBar := QMenuBar new.
	window setMenuBar: menuBar.
	self assert: [ window menuBar = menuBar ].

	centralWidget := QWidget new.
	window setCentralWidget: centralWidget.
	self assert: [ window centralWidget = centralWidget ].
!
testStatusBar
	| window statusBar |
	window := QMainWindow new.
	statusBar := QStatusBar new.
	window setStatusBar: statusBar.
	self assert: [ window statusBar = statusBar ].

	"Without a status bar, an empty one is created."
	window setStatusBar: nil.
	self assert: [ window statusBar class = QStatusBar ].
	self assert: [ window statusBar ~= statusBar ].
!
