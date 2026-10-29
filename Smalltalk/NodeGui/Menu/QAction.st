CLASS QAction EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"A command that can be added to menus, menu bars and tool buttons, with QWidget addAction:.
 NodeGui has no JS getters for most properties, so those are read as Qt properties.
 NodeGui cannot trigger an action, but setChecked: fires the 'toggled' event."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QAction()'.
!

"Shortcut context enums, also used by QShortcut"

widgetShortcut
	"The shortcut is active when the parent widget has focus."
	^ 0.
!
windowShortcut
	"The shortcut is active when the parent widget is in the active window."
	^ 1.
!
applicationShortcut
	"The shortcut is active when any window of the application is active."
	^ 2.
!
widgetWithChildrenShortcut
	"The shortcut is active when the parent widget or one of its children has focus."
	^ 3.
!

METHODS

"Text"

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	^ String fromJs: INLINE 'this.js.property( "text" ).toString()'.
!
setToolTip: toolTip
	"By default the tool tip is the text."
	INLINE 'this.js.setProperty( "toolTip", toolTip.js )'.
!
toolTip
	^ String fromJs: INLINE 'this.js.property( "toolTip" ).toString()'.
!

"State"

setEnabled: enabled
	INLINE 'this.js.setEnabled( enabled.js )'.
!
isEnabled
	^ Boolean fromJs: INLINE 'this.js.property( "enabled" ).toBool()'.
!
setCheckable: checkable
	INLINE 'this.js.setCheckable( checkable.js )'.
!
isCheckable
	^ Boolean fromJs: INLINE 'this.js.isCheckable()'.
!
setChecked: checked
	"Only has effect if the action is checkable.
	 Qt remembers the checked state, so it applies when the action becomes checkable."
	INLINE 'this.js.setChecked( checked.js )'.
!
isChecked
	^ Boolean fromJs: INLINE 'this.js.isChecked()'.
!

"Look"

setIcon: icon
	INLINE 'this.js.setIcon( icon.js )'.
!
setSeparator: separator
	"A separator action is shown as a line in a menu."
	INLINE 'this.js.setSeparator( separator.js )'.
!
isSeparator
	^ Boolean fromJs: INLINE 'this.js.isSeparator()'.
!
setMenu: menu
	"Show menu as a submenu of this action."
	INLINE 'this.js.setMenu( menu.js )'.
!

"Shortcut"

setShortcut: keySequence
	INLINE 'this.js.setShortcut( keySequence.js )'.
!
shortcut
	^ QKeySequence fromVariant: ( self property: 'shortcut' ).
!
setShortcutContext: shortcutContext
	"Use the shortcut context enums, the default is windowShortcut."
	INLINE 'this.js.setShortcutContext( shortcutContext.js )'.
!
shortcutContext
	^ Integer fromJs: INLINE 'this.js.property( "shortcutContext" ).toInt()'.
!

"Data"

setData: variant
	"Variant is a QVariant holding user data."
	INLINE 'this.js.setData( variant.js )'.
!
data
	^ QVariant fromJs: INLINE 'this.js.data()'.
!

"Events"

onTrigger: block
	"Block is called when the user activates the action, e.g. by clicking its menu item or using its shortcut."
	self addEventListener: 'triggered' then: [ block value ].
!
onToggle: block
	"Block is called when the checked state changes, also when set by code."
	self addEventListener: 'toggled' then: [ block value ].
!
onHover: block
	self addEventListener: 'hovered' then: [ block value ].
!
onChange: block
	"Block is called when a property of the action changes, e.g. its text or checked state."
	self addEventListener: 'changed' then: [ block value ].
!
