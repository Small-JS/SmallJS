CLASS QMenuBar EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A horizontal bar of menus, set on a window with QMainWindow setMenuBar:.
 Some NodeGui JS methods are broken, so these methods call the native object or Qt properties directly:
 addSeparator() answers an unusable object, setCornerWidget() passes the JS object
 and isNativeMenuBar() and isDefaultUp() read wrong properties.
 setActiveAction() is not wrapped, because it crashes Qt when the menu bar is not shown."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QMenuBar()'.
!

"Corner enums"

topLeftCorner
	^ 0.
!
topRightCorner
	^ 1.
!

METHODS

"Adding"

addMenu: menu
	INLINE 'this.js.addMenu( menu.js )'.
!
addMenuWithTitle: title
	"Add a new menu with title and answer it."
	^ QMenu fromJs: INLINE 'this.js.addMenu( title.js )'.
!
addSeparator
	"Add a separator and answer its action.
	 Depending on the style, separators are not shown in menu bars."
	| action |
	action := QAction new.
	action setSeparator: true.
	self addAction: action.
	^ action.
!

"Inserting before an action"

insertMenu: menu before: beforeAction
	"Answer the action of menu."
	^ QAction fromJs: INLINE 'this.js.insertMenu( beforeAction.js, menu.js )'.
!
insertSeparator: beforeAction
	"Answer the action of the separator."
	^ QAction fromJs: INLINE 'this.js.insertSeparator( beforeAction.js )'.
!

"Actions"

clear
	"Remove all menus and actions."
	INLINE 'this.js.clear()'.
!
activeAction
	"Answer the highlighted action, or nil if there is none."
	^ QAction fromJs: INLINE 'this.js.activeAction()'.
!

"Corner widget"

setCornerWidget: widget
	"Show widget in the top right corner."
	self setCornerWidget: widget corner: QMenuBar topRightCorner.
!
setCornerWidget: widget corner: corner
	INLINE 'this.js.native.setCornerWidget( widget.js.native, corner.js )'.
!
cornerWidget
	^ self cornerWidget: QMenuBar topRightCorner.
!
cornerWidget: corner
	"Answer nil if there is none."
	^ QWidget fromJs: INLINE 'this.js.cornerWidget( corner.js )'.
!

"Options"

setNativeMenuBar: nativeMenuBar
	"A native menu bar is shown by the platform, e.g. at the top of the screen on macOS.
	 Not supported on Windows."
	INLINE 'this.js.setNativeMenuBar( nativeMenuBar.js )'.
!
isNativeMenuBar
	^ Boolean fromJs: INLINE 'this.js.property( "nativeMenuBar" ).toBool()'.
!
setDefaultUp: defaultUp
	"If defaultUp, menus pop up above the menu bar, e.g. for a menu bar at the bottom of a window."
	INLINE 'this.js.setDefaultUp( defaultUp.js )'.
!
isDefaultUp
	^ Boolean fromJs: INLINE 'this.js.property( "defaultUp" ).toBool()'.
!

"Events"

onTrigger: block
	"Block is called with the QAction the user triggered in one of the menus."
	INLINE 'this.js.addEventListener( "triggered", native => block.$value$( stQAction$class.$fromJs$( nodegui$.wrapperCache.getWrapper( native ) ) ) )'.
!
onHover: block
	"Block is called with the QAction the user highlighted."
	INLINE 'this.js.addEventListener( "hovered", native => block.$value$( stQAction$class.$fromJs$( nodegui$.wrapperCache.getWrapper( native ) ) ) )'.
!
