CLASS TestQMenuBar EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| menuBar menu |
	menuBar := QMenuBar new.
	self assert: [ menuBar jsClassName = 'QMenuBar' ].

	menu := QMenu new setTitle: 'My Menu'.
	menuBar addMenu: menu.
	menu := menuBar addMenuWithTitle: 'My Other Menu'.
	self assert: [ menu class = QMenu ].
	self assert: [ menu title = 'My Other Menu' ].
	self assert: [ menuBar addSeparator isSeparator ].
	menuBar clear.
!
testInserting
	| menuBar menu1 menu2 |
	menuBar := QMenuBar new.
	menu1 := QMenu new setTitle: 'Menu 1'.
	menu2 := QMenu new setTitle: 'Menu 2'.
	menuBar addMenu: menu2.

	self assert: [ ( menuBar insertMenu: menu1 before: menu2 menuAction ) = menu1 menuAction ].
	self assert: [ ( menuBar insertSeparator: menu2 menuAction ) isSeparator ].
	self assert: [ menuBar activeAction isNil ].
!
testCornerWidget
	| menuBar label |
	menuBar := QMenuBar new.
	self assert: [ menuBar cornerWidget isNil ].

	label := QLabel new.
	menuBar setCornerWidget: label.
	self assert: [ menuBar cornerWidget = label ].
	self assert: [ ( menuBar cornerWidget: QMenuBar topLeftCorner ) isNil ].
!
testOptions
	| menuBar |
	menuBar := QMenuBar new.
	self assert: [ menuBar isDefaultUp not ].
	menuBar setDefaultUp: true.
	self assert: [ menuBar isDefaultUp ].

	"A native menu bar is not supported on all platforms, so restore the setting."
	menuBar setNativeMenuBar: false.
	self assert: [ menuBar isNativeMenuBar not ].
!
testEvents
	"The events are fired by user interaction only, so just check that listeners can be added."
	| menuBar |
	menuBar := QMenuBar new.
	menuBar onTrigger: [ :action | self assert: [ false ] ].
	menuBar onHover: [ :action | self assert: [ false ] ].
!
