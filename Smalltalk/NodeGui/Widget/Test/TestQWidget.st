CLASS TestQWidget EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"The widgets are not shown, to not open windows during the tests.
 Showing and the events of visible widgets are tested in the GUI tests of the app."

test
	| widget |

	widget := QWidget new.
	self assert: [ widget jsClassName = 'QWidget' ].

	widget setWindowTitle: 'My Window Title'.
	self assert: [ widget windowTitle = 'My Window Title' ].

	widget setStyleSheet: '#root { align-items: "center" }'.
	self assert: [ widget styleSheet startsWith: '#root' ].

	widget setWindowIcon: QIcon new.
	self assert: [ widget windowIcon jsClassName = 'QIcon' ].
!
testWindow
	| widget child |
	widget := QWidget new.
	child := QWidget new.
	child setParent: widget.
	self assert: [ widget isWindow ].
	self assert: [ child isWindow not ].
	self assert: [ widget window = widget ].
	self assert: [ child window = widget ].
	self assert: [ child parentWidget = widget ].
	self assert: [ widget parentWidget isNil ].

	self assert: [ widget isWindowModified not ].
	widget setWindowModified: true.
	self assert: [ widget isWindowModified ].
	widget setWindowOpacity: 0.5.
	self assert: [ ( widget windowOpacity - 0.5 ) abs < 0.01 ].

	"A child with a window type is a window."
	child setWindowFlag: QWidget popup on: true.
	self assert: [ child isWindow ].
	child setWindowFlag: QWidget popup on: false.
	self assert: [ child isWindow not ].
	widget setWindowFlag: QWidget windowStaysOnTopHint on: true.

	self assert: [ widget isMaximized not ].
	self assert: [ widget isMinimized not ].
	self assert: [ widget isFullScreen not ].
	self assert: [ widget isActiveWindow not ].
!
testHiding
	"A widget is hidden until it is shown."
	| widget |
	widget := QWidget new.
	self assert: [ widget isVisible not ].
	self assert: [ widget isHidden ].
	widget setHidden: false.
	self assert: [ widget isHidden not ].
	widget hide.
	self assert: [ widget isHidden ].
!
testEnabling
	| widget child |
	widget := QWidget new.
	child := QWidget new.
	child setParent: widget.
	self assert: [ widget isEnabled ].

	"Disabling a widget disables its children."
	widget setEnabled: false.
	self assert: [ widget isEnabled not ].
	self assert: [ child isEnabled not ].
	widget setEnabled: true.
	self assert: [ child isEnabled ].
!
testHelpTexts
	| widget |
	widget := QWidget new.
	self assert: [ widget toolTip = '' ].
	widget setToolTip: 'My Tool Tip'.
	self assert: [ widget toolTip = 'My Tool Tip' ].
	widget setStatusTip: 'My Status Tip'.
	self assert: [ widget statusTip = 'My Status Tip' ].
	widget setWhatsThis: 'My Whats This'.
	self assert: [ widget whatsThis = 'My Whats This' ].
!
testSize
	| widget |
	widget := QWidget new.
	widget resize: ( QSize width: 200 height: 100 ).
	self assert: [ widget size = ( QSize width: 200 height: 100 ) ].
	self assert: [ widget width = 200 ].
	self assert: [ widget height = 100 ].

	widget setMinimumSize: ( QSize width: 50 height: 40 ).
	self assert: [ widget minimumSize = ( QSize width: 50 height: 40 ) ].
	widget setMaximumSize: ( QSize width: 500 height: 400 ).
	self assert: [ widget maximumSize = ( QSize width: 500 height: 400 ) ].

	"The size is kept between the minimum and maximum size."
	widget resize: ( QSize width: 10 height: 1000 ).
	self assert: [ widget size = ( QSize width: 50 height: 400 ) ].

	widget setFixedSize: ( QSize width: 80 height: 60 ).
	self assert: [ widget size = ( QSize width: 80 height: 60 ) ].
	self assert: [ widget minimumSize = widget maximumSize ].
	widget setFixedWidth: 90.
	widget setFixedHeight: 70.
	self assert: [ widget size = ( QSize width: 90 height: 70 ) ].
!
testSizeHint
	"A widget without layout has no size hint, a label has one."
	| label |
	self assert: [ QWidget new sizeHint isValid not ].
	label := QLabel new setText: 'My Label'.
	self assert: [ label sizeHint isValid ].
	self assert: [ label minimumSizeHint isValid ].
	label adjustSize.
	self assert: [ label size = label sizeHint ].
!
testPosition
	| widget child |
	widget := QWidget new.
	widget move: ( QPoint x: 30 y: 40 ).
	self assert: [ widget pos = ( QPoint x: 30 y: 40 ) ].
	self assert: [ widget x = 30 ].
	self assert: [ widget y = 40 ].

	widget setGeometry: ( QRect left: 10 top: 20 width: 200 height: 100 ).
	self assert: [ widget geometry = ( QRect left: 10 top: 20 width: 200 height: 100 ) ].
	self assert: [ widget rect = ( QRect left: 0 top: 0 width: 200 height: 100 ) ].

	"Mapping to global coordinates and back answers the same point."
	child := QWidget new.
	child setParent: widget.
	child move: ( QPoint x: 5 y: 6 ).
	self assert: [ ( child mapFromGlobal: ( child mapToGlobal: ( QPoint x: 1 y: 2 ) ) ) = ( QPoint x: 1 y: 2 ) ].
	child resize: ( QSize width: 20 height: 10 ).
	self assert: [ ( widget childAt: ( QPoint x: 6 y: 7 ) ) = child ].
	self assert: [ ( widget childAt: ( QPoint x: 100 y: 50 ) ) isNil ].
	"Hidden children are not found."
	child hide.
	self assert: [ ( widget childAt: ( QPoint x: 6 y: 7 ) ) isNil ].
!
testLayout
	| widget layout |
	widget := QWidget new.
	self assert: [ widget layout isNil ].
	layout := QBoxLayout new: QLayout topToBottom.
	widget setLayout: layout.
	self assert: [ widget layout = layout ].
	widget setContentsMargins: 1 top: 2 right: 3 bottom: 4.
!
testFocus
	| widget |
	widget := QWidget new.
	self assert: [ widget focusPolicy = QWidget noFocus ].
	widget setFocusPolicy: QWidget strongFocus.
	self assert: [ widget focusPolicy = QWidget strongFocus ].
	"A hidden widget cannot get focus."
	widget setFocus.
	self assert: [ widget hasFocus not ].
	widget clearFocus.
!
testStyle
	| widget |
	widget := QWidget new.
	widget setCursor: QWidget pointingHandCursor.
	widget update.
	widget repaint.
	widget raise.
	widget lower.
!
testEvents
	"The events of visible widgets are tested in the GUI tests of the app."
	| widget |
	widget := QWidget new.
	widget onShow: [ self assert: [ false ] ].
	widget onHide: [ self assert: [ false ] ].
	widget onResize: [ self assert: [ false ] ].
	widget onMove: [ self assert: [ false ] ].
	widget onFocusIn: [ self assert: [ false ] ].
	widget onFocusOut: [ self assert: [ false ] ].
	widget onMousePress: [ self assert: [ false ] ].
	widget onMouseRelease: [ self assert: [ false ] ].
	widget onMouseDoubleClick: [ self assert: [ false ] ].
	widget onKeyPress: [ self assert: [ false ] ].
	widget onKeyRelease: [ self assert: [ false ] ].
	widget onClose: [ ].
!
