CLASS NwMenuItem EXTENDS NwEventEmitter MODULE Nwjs CLASSVARS '' VARS ''

CLASSMETHODS

new: label
	^ self fromJs: INLINE 'new gui.MenuItem( { label: label.js } )'.
!
checkbox: label
	^ self fromJs: INLINE 'new gui.MenuItem( { label: label.js, type: "checkbox" } )'.
!
separator
	^ self fromJs: INLINE 'new gui.MenuItem( { type: "separator" } )'.
!

METHODS

type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js '.
!

"Appearance"

label
	^ String fromJs: INLINE 'this.js.label'.
!
label: label
	INLINE 'this.js.label = label.js '.
!
icon
	^ String fromJs: INLINE 'this.js.icon'.
!
icon: icon
	INLINE 'this.js.icon = icon.js '.
!
tooltip
	^ String fromJs: INLINE 'this.js.tooltip'.
!
tooltip: tooltip
	INLINE 'this.js.tooltip = tooltip.js '.
!

"Status"

enabled
	^ Boolean fromJs: INLINE 'this.js.enabled'.
!
enabled: enabled
	INLINE 'this.js.enabled = enabled.js '.
!
checked
	^ Boolean fromJs: INLINE 'this.js.checked'.
!
checked: checked
	INLINE 'this.js.checked = checked.js '.
!

"Actions"

click
	^ Block fromJs: INLINE 'this.js.click'.
!
click: block
	INLINE 'this.js.click = () => block.js()'.
!
submenu
	^ NwMenu fromJs: INLINE 'this.js.submenu'.
!
submenu: submenu
	INLINE 'this.js.submenu = submenu.js '.
!

"Shortcut"

key
	^ String fromJs: INLINE 'this.js.key'.
!
key: key
	"2025-08-14 Setting the menu item key currently crashes Nw.js on Windows:
	 This has been reported here: https://github.com/nwjs/nw.js/issues/8290"
	INLINE 'this.js.key = key.js '.
!
modifiers
	^ String fromJs: INLINE 'this.js.modifiers'.
!
modifiers: modifiers
	"2025-08-14 Setting the menu item modifiers corrently crashes Nw.js on Windows:
	 This has been reported here: https://github.com/nwjs/nw.js/issues/8290"
	INLINE 'this.js.modifiers = modifiers.js '.
!

