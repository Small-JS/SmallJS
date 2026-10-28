CLASS TestQToolButton EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| toolButton |
	toolButton := QToolButton new.
	self assert: [ toolButton jsClassName = 'QToolButton' ].

	toolButton setText: 'My Tool Button'.
	self assert: [ toolButton text = 'My Tool Button' ].
!
testAppearance
	| toolButton |
	toolButton := QToolButton new.

	self assert: [ toolButton arrowType = QToolButton noArrow ].
	toolButton setArrowType: QToolButton downArrow.
	self assert: [ toolButton arrowType = QToolButton downArrow ].

	self assert: [ toolButton autoRaise not ].
	toolButton setAutoRaise: true.
	self assert: [ toolButton autoRaise ].

	self assert: [ toolButton toolButtonStyle = QToolButton iconOnly ].
	toolButton setToolButtonStyle: QToolButton textUnderIcon.
	self assert: [ toolButton toolButtonStyle = QToolButton textUnderIcon ].
!
testMenu
	| toolButton menu |
	toolButton := QToolButton new.
	"Getting the menu is not implemented in NodeGui."
	self assertError: [ toolButton menu ].

	menu := QMenu new.
	menu setTitle: 'My Menu'.
	toolButton setMenu: menu.

	self assert: [ toolButton popupMode = QToolButton delayedPopup ].
	toolButton setPopupMode: QToolButton instantPopup.
	self assert: [ toolButton popupMode = QToolButton instantPopup ].
!
testDefaultAction
	| toolButton action triggerCount |
	toolButton := QToolButton new.
	self assert: [ toolButton defaultAction isNil ].

	action := QAction new.
	action setText: 'My Action'.
	triggerCount := 0.
	action addEventListener: 'triggered' then: [ triggerCount := triggerCount + 1 ].

	toolButton setDefaultAction: action.
	self assert: [ toolButton defaultAction = action ].
	"The button takes its text from the action, and triggers it when clicked."
	self assert: [ toolButton text = 'My Action' ].
	toolButton click.
	self assert: [ triggerCount = 1 ].
!
