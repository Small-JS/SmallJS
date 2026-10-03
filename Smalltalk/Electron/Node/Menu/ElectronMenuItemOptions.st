CLASS ElectronMenuItemOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Partially implements Electron JS interface: MenuItemConstructorOptions."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Properties"

role
	^ String fromJs: INLINE 'this.js.role'.
!
role: role
	INLINE 'this.js.role = role.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
label
	^ String fromJs: INLINE 'this.js.label'.
!
label: label
	INLINE 'this.js.label = label.js'.
!
accelerator
	^ String fromJs: INLINE 'this.js.accelerator'.
!
accelerator: accelerator
	INLINE 'this.js.accelerator = accelerator.js'.
!
enabled
	^ Boolean fromJs: INLINE 'this.js.enabled'.
!
enabled: enabled
	INLINE 'this.js.enabled = enabled.js'.
!
visible
	^ Boolean fromJs: INLINE 'this.js.visible'.
!
visible: visible
	INLINE 'this.js.visible = visible.js'.
!
submenu
	^ ElectronMenu fromJs: INLINE 'this.js.submenu'.
!
submenu: submenu
	INLINE 'this.js.submenu = submenu.js'.
!
id
	^ String fromJs: INLINE 'this.js.id'.
!
id: id
	"Unique within a single menu. Used by ElectronMenu>>menuItemById: and the positioning properties."
	INLINE 'this.js.id = id.js'.
!
checked
	^ Boolean fromJs: INLINE 'this.js.checked'.
!
checked: checked
	"Note: Only meaningful for items of type 'checkbox' or 'radio'."
	INLINE 'this.js.checked = checked.js'.
!
icon
	"Note: Only returns the icon if it was set as a file path string."
	^ String fromJs: INLINE '( typeof this.js.icon === "string" ? this.js.icon : null )'.
!
icon: path
	INLINE 'this.js.icon = path.js'.
!

"Positioning
 Note: These are only used when building a menu from a template, not by append or insert.
 The argument is an Array of menu item ids."

before
	^ Array fromJsStrings: INLINE 'this.js.before'.
!
before: ids
	INLINE 'this.js.before = ids.$toJs()'.
!
after
	^ Array fromJsStrings: INLINE 'this.js.after'.
!
after: ids
	INLINE 'this.js.after = ids.$toJs()'.
!
beforeGroupContaining
	^ Array fromJsStrings: INLINE 'this.js.beforeGroupContaining'.
!
beforeGroupContaining: ids
	INLINE 'this.js.beforeGroupContaining = ids.$toJs()'.
!
afterGroupContaining
	^ Array fromJsStrings: INLINE 'this.js.afterGroupContaining'.
!
afterGroupContaining: ids
	INLINE 'this.js.afterGroupContaining = ids.$toJs()'.
!

"Events"

click: block
	INLINE 'this.js.click = block.js'.
!
