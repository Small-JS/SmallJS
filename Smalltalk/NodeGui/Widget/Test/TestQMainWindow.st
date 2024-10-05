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
