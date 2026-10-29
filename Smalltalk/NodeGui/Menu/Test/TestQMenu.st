CLASS TestQMenu EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| menu action |
	menu := QMenu new.
	self assert: [ menu jsClassName = 'QMenu' ].
	self assert: [ menu isEmpty ].

	menu setTitle: 'My Title'.
	self assert: [ menu title = 'My Title' ].
	self assert: [ menu menuAction jsClassName = 'QAction' ].
	self assert: [ menu menuAction text = 'My Title' ].

	menu setIcon: ( QIcon new: 'assets/logo.png' ).
	self assert: [ menu icon jsClassName = 'QIcon' ].

	action := QAction new.
	menu addAction: action.
	self assert: [ menu isEmpty not ].
	menu removeAction: action.
	self assert: [ menu isEmpty ].
!
testAdding
	| menu subMenu separator section menuAction |
	menu := QMenu new.

	separator := menu addSeparator.
	self assert: [ separator isSeparator ].
	section := menu addSection: 'My Section'.
	self assert: [ section isSeparator ].
	self assert: [ section text = 'My Section' ].

	subMenu := QMenu new setTitle: 'Sub 1'.
	menuAction := menu addMenu: subMenu.
	self assert: [ menuAction = subMenu menuAction ].
	subMenu := menu addMenuWithTitle: 'Sub 2'.
	self assert: [ subMenu class = QMenu ].
	self assert: [ subMenu title = 'Sub 2' ].

	menu clear.
	self assert: [ menu isEmpty ].
!
testInserting
	| menu action subMenu |
	menu := QMenu new.
	action := QAction new setText: 'My Action'.
	menu addAction: action.

	self assert: [ ( menu insertSeparator: action ) isSeparator ].
	self assert: [ ( menu insertSection: 'My Section' before: action ) text = 'My Section' ].
	subMenu := QMenu new setTitle: 'Sub'.
	self assert: [ ( menu insertMenu: subMenu before: action ) = subMenu menuAction ].
!
testActions
	| menu action |
	menu := QMenu new.
	action := QAction new.
	menu addAction: action.

	self assert: [ menu defaultAction isNil ].
	menu setDefaultAction: action.
	self assert: [ menu defaultAction = action ].

	self assert: [ menu activeAction isNil ].
	menu setActiveAction: action.
	self assert: [ menu activeAction = action ].
!
testOptions
	| menu |
	menu := QMenu new.
	self assert: [ menu toolTipsVisible not ].
	menu setToolTipsVisible: true.
	self assert: [ menu toolTipsVisible ].

	self assert: [ menu separatorsCollapsible ].
	menu setSeparatorsCollapsible: false.
	self assert: [ menu separatorsCollapsible not ].

	self assert: [ menu isTearOffEnabled not ].
	menu setTearOffEnabled: true.
	self assert: [ menu isTearOffEnabled ].
!
testEvents
	"The events are fired by user interaction only, so just check that listeners can be added."
	| menu |
	menu := QMenu new.
	menu onAboutToShow: [ self assert: [ false ] ].
	menu onAboutToHide: [ self assert: [ false ] ].
	menu onTrigger: [ :action | self assert: [ false ] ].
	menu onHover: [ :action | self assert: [ false ] ].
!
