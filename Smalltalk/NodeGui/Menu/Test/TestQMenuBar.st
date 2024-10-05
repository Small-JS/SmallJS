CLASS TestQMenuBar EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"Also tests QMenu and QAction"

test
	| action menu menuBar |

	"========================= Action"

	action := QAction new.
	self assert: [ action jsClassName = 'QAction' ].

	action setText: 'My Action'.
	"QAction.text() not implemented in NodeGui yet (5-OCT-2024)"
	"self assert: [ action text = 'My Action' ]."

	action addEventListener: 'triggered' then: [ self onAction ].
	"QAction.activate() not implemented in NodeGui yet (5-OCT-2024)"
	"action activate."

	"========================= Menu"

	menu := QMenu new.
	self assert: [ menu jsClassName = 'QMenu' ].

	menu setTitle: 'My Title'.
	self assert: [ menu title = 'My Title' ].

	menu addAction: action.
	self assert: [ menu menuAction jsClassName = 'QAction' ].

	"========================= MenuBar"

	menuBar := QMenuBar new.
	self assert: [ menuBar jsClassName = 'QMenuBar' ].

	menuBar addMenu: menu.
!
onAction
	"Never called."
	self assert: [ true ].
!
