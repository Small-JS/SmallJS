CLASS QWidget EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"The base class of all widgets. A widget without a parent is a window.
 Positions and sizes are in pixels. Some events, e.g. 'Resize' and 'Move', only fire for visible widgets."

CLASSMETHODS

"Creation"

new
	^ self fromJs: INLINE 'new nodegui$.QWidget()'.
!

"Focus policy enums"

noFocus
	^ 0.
!
tabFocus
	^ 1.
!
clickFocus
	^ 2.
!
strongFocus
	"Tab and click focus."
	^ 11.
!
wheelFocus
	"Strong focus and mouse wheel focus."
	^ 15.
!

"Window type and hint enums, used by setWindowFlag:on:.
 These are the Qt values, some values of the NodeGui enum WindowType differ."

window
	^ 1.
!
dialog
	^ 3.
!
popup
	"A popup window, e.g. a menu. It closes when the user clicks outside it."
	^ 9.
!
tool
	"A small window that stays on top of its parent window."
	^ 11.
!
framelessWindowHint
	^ 2048.
!
windowStaysOnTopHint
	^ 262144.
!

"Cursor shape enums, used by setCursor:"

arrowCursor
	^ 0.
!
crossCursor
	^ 2.
!
waitCursor
	^ 3.
!
iBeamCursor
	^ 4.
!
pointingHandCursor
	^ 13.
!
forbiddenCursor
	^ 14.
!
busyCursor
	^ 16.
!

METHODS

"Actions"

addAction: action
	INLINE 'this.js.addAction( action.js )'.
!
removeAction: action
	INLINE 'this.js.removeAction( action.js )'.
!

"Layout"

setLayout: layout
	INLINE 'this.js.setLayout( layout.js )'.
!
layout
	"Answer nil if there is no layout."
	^ QLayout fromJs: INLINE 'this.js.layout()'.
!
setContentsMargins: left top: top right: right bottom: bottom
	"Margins around the layout of this widget."
	INLINE 'this.js.setContentsMargins( left.js, top.js, right.js, bottom.js )'.
!
setSizePolicy: horizontal vertical: vertical
	"Use the QSizePolicy enums. NodeGui cannot read the size policy back."
	INLINE 'this.js.setSizePolicy( horizontal.js, vertical.js )'.
!

"Style"

setInlineStyle: style
	INLINE 'this.js.setInlineStyle( style.js )'.
!
setStyleSheet: styleSheet
	"Note: styleSheet should be string."
	INLINE 'this.js.setStyleSheet( styleSheet.js )'.
!
styleSheet
	^ String fromJs: INLINE 'this.js.styleSheet()'.
!
setCursor: cursorShape
	"Use the cursor shape enums."
	INLINE 'this.js.setCursor( cursorShape.js )'.
!
update
	"Repaint the widget when control returns to the event loop."
	INLINE 'this.js.update()'.
!
repaint
	"Repaint the widget immediately."
	INLINE 'this.js.repaint()'.
!

"Window"

setWindowTitle: title
	INLINE 'this.js.setWindowTitle( title.js )'.
!
windowTitle
	^ String fromJs: INLINE 'this.js.windowTitle()'.
!
setWindowIcon: icon
	INLINE 'this.js.setWindowIcon( icon.js )'.
!
windowIcon
	^ QIcon fromJs: INLINE 'this.js.windowIcon()'.
!
setWindowOpacity: opacity
	"Opacity from 0.0 (transparent) to 1.0 (opaque). Only for windows, if supported by the platform."
	INLINE 'this.js.setWindowOpacity( opacity.js )'.
!
windowOpacity
	^ Float fromJs: INLINE 'this.js.windowOpacity()'.
!
setWindowFlag: flag on: on
	"Turn a window type or hint enum on or off. A widget with a window type is a window, also with a parent.
	 Set the window type before showing the widget."
	INLINE 'this.js.setWindowFlag( flag.js, on.js )'.
!
setWindowModified: modified
	"A modified window shows '*' in its title, at the placeholder '[*]' of the title."
	INLINE 'this.js.setWindowModified( modified.js )'.
!
isWindowModified
	^ Boolean fromJs: INLINE 'this.js.isWindowModified()'.
!
isWindow
	"Answer true if this widget has no parent widget."
	^ Boolean fromJs: INLINE 'this.js.isWindow()'.
!
window
	"Answer the window of this widget, or this widget if it is a window."
	^ QWidget fromJs: INLINE 'this.js.window()'.
!
parentWidget
	"Answer nil if there is no parent widget."
	^ QWidget fromJs: INLINE 'this.js.parentWidget()'.
!

"Showing"

show
	INLINE 'this.js.show()'.
!
hide
	INLINE 'this.js.hide()'.
!
close
	"Close the widget, it is hidden. Answer true if it was closed."
	^ Boolean fromJs: INLINE 'this.js.close()'.
!
setVisible: visible
	INLINE 'this.js.setVisible( visible.js )'.
!
isVisible
	"Answer true if this widget and its parents are shown."
	^ Boolean fromJs: INLINE 'this.js.isVisible()'.
!
setHidden: hidden
	INLINE 'this.js.setHidden( hidden.js )'.
!
isHidden
	"Answer true if this widget is explicitly hidden. A widget that is not shown yet is hidden too."
	^ Boolean fromJs: INLINE 'this.js.isHidden()'.
!
showMaximized
	INLINE 'this.js.showMaximized()'.
!
showMinimized
	INLINE 'this.js.showMinimized()'.
!
showFullScreen
	INLINE 'this.js.showFullScreen()'.
!
showNormal
	"Show the window in its normal size, after it was maximized, minimized or full screen."
	INLINE 'this.js.showNormal()'.
!
isMaximized
	^ Boolean fromJs: INLINE 'this.js.isMaximized()'.
!
isMinimized
	^ Boolean fromJs: INLINE 'this.js.isMinimized()'.
!
isFullScreen
	^ Boolean fromJs: INLINE 'this.js.isFullScreen()'.
!
isActiveWindow
	^ Boolean fromJs: INLINE 'this.js.isActiveWindow()'.
!
activateWindow
	"Make the window of this widget the active window, if allowed by the platform."
	INLINE 'this.js.activateWindow()'.
!
raise
	"Show this widget on top of its siblings."
	INLINE 'this.js.raise()'.
!
lower
	"Show this widget below its siblings."
	INLINE 'this.js.lower()'.
!

"Enabling"

setEnabled: enabled
	"A disabled widget and its children do not handle user input."
	INLINE 'this.js.setEnabled( enabled.js )'.
!
isEnabled
	^ Boolean fromJs: INLINE 'this.js.isEnabled()'.
!

"Help texts"

setToolTip: toolTip
	INLINE 'this.js.setToolTip( toolTip.js )'.
!
toolTip
	^ String fromJs: INLINE 'this.js.toolTip()'.
!
setStatusTip: statusTip
	"The status tip is shown in the status bar of the main window, when the mouse is over this widget."
	INLINE 'this.js.setStatusTip( statusTip.js )'.
!
statusTip
	^ String fromJs: INLINE 'this.js.statusTip()'.
!
setWhatsThis: whatsThis
	"Help text shown in 'What's this?' mode."
	INLINE 'this.js.setWhatsThis( whatsThis.js )'.
!
whatsThis
	^ String fromJs: INLINE 'this.js.whatsThis()'.
!

"Size"

resize: size
	INLINE 'this.js.resize( size.$width().js, size.$height().js )'.
!
size
	^ QSize fromJs: INLINE 'this.js.size()'.
!
width
	^ Integer fromJs: INLINE 'this.js.width()'.
!
height
	^ Integer fromJs: INLINE 'this.js.height()'.
!
setMinimumSize: size
	INLINE 'this.js.setMinimumSize( size.$width().js, size.$height().js )'.
!
minimumSize
	^ QSize fromJs: INLINE 'this.js.minimumSize()'.
!
setMaximumSize: size
	INLINE 'this.js.setMaximumSize( size.$width().js, size.$height().js )'.
!
maximumSize
	^ QSize fromJs: INLINE 'this.js.maximumSize()'.
!
setFixedSize: size
	"Set both the minimum and maximum size to size."
	INLINE 'this.js.setFixedSize( size.$width().js, size.$height().js )'.
!
setFixedWidth: width
	INLINE 'this.js.setFixedWidth( width.js )'.
!
setFixedHeight: height
	INLINE 'this.js.setFixedHeight( height.js )'.
!
sizeHint
	"Answer the recommended size, or an invalid size if there is none."
	^ QSize fromJs: INLINE 'this.js.sizeHint()'.
!
minimumSizeHint
	^ QSize fromJs: INLINE 'this.js.minimumSizeHint()'.
!
adjustSize
	"Resize to fit the contents."
	INLINE 'this.js.adjustSize()'.
!

"Position"

move: point
	"Move to point, relative to the parent widget, or the screen for a window."
	INLINE 'this.js.move( point.$x().js, point.$y().js )'.
!
pos
	"JS pos() answers a plain object, so make a QPoint."
	^ QPoint x: self x y: self y.
!
x
	^ Integer fromJs: INLINE 'this.js.x()'.
!
y
	^ Integer fromJs: INLINE 'this.js.y()'.
!
setGeometry: rect
	"Set position and size, relative to the parent widget."
	INLINE 'this.js.setGeometry( rect.$left().js, rect.$top().js, rect.$width().js, rect.$height().js )'.
!
geometry
	"Answer position and size, relative to the parent widget."
	^ QRect fromJs: INLINE 'this.js.geometry()'.
!
rect
	"Answer the inside of the widget: left and top are 0, width and height are its size."
	^ QRect fromJs: INLINE 'this.js.rect()'.
!
mapToGlobal: point
	"Answer point, relative to this widget, in screen coordinates."
	^ QPoint fromJs: INLINE 'this.js.mapToGlobal( point.js )'.
!
mapFromGlobal: point
	"Answer point, in screen coordinates, relative to this widget."
	^ QPoint fromJs: INLINE 'this.js.mapFromGlobal( point.js )'.
!
childAt: point
	"Answer the child widget at point, relative to this widget, or nil if there is none.
	 Hidden children are skipped."
	^ QWidget fromJs: INLINE 'this.js.childAt( point.$x().js, point.$y().js )'.
!

"Focus"

setFocus
	INLINE 'this.js.setFocus()'.
!
clearFocus
	INLINE 'this.js.clearFocus()'.
!
hasFocus
	^ Boolean fromJs: INLINE 'this.js.hasFocus()'.
!
setFocusPolicy: focusPolicy
	"Use the focus policy enums."
	INLINE 'this.js.setFocusPolicy( focusPolicy.js )'.
!
focusPolicy
	^ Integer fromJs: INLINE 'this.js.property( "focusPolicy" ).toInt()'.
!

"Events"

onShow: block
	self addEventListener: 'Show' then: [ block value ].
!
onHide: block
	self addEventListener: 'Hide' then: [ block value ].
!
onClose: block
	self addEventListener: 'Close' then: [ block value ].
!
onResize: block
	self addEventListener: 'Resize' then: [ block value ].
!
onMove: block
	self addEventListener: 'Move' then: [ block value ].
!
onFocusIn: block
	self addEventListener: 'FocusIn' then: [ block value ].
!
onFocusOut: block
	self addEventListener: 'FocusOut' then: [ block value ].
!
onMousePress: block
	self addEventListener: 'MouseButtonPress' then: [ block value ].
!
onMouseRelease: block
	self addEventListener: 'MouseButtonRelease' then: [ block value ].
!
onMouseDoubleClick: block
	self addEventListener: 'MouseButtonDblClick' then: [ block value ].
!
onKeyPress: block
	self addEventListener: 'KeyPress' then: [ block value ].
!
onKeyRelease: block
	self addEventListener: 'KeyRelease' then: [ block value ].
!
