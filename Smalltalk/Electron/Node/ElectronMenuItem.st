CLASS ElectronMenuItem EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS class: MenuItem.
 Note: Platform specific funcionality is not implemented, keeping it standard.
 Writable properties have a setter, the others are read-only after creation."

CLASSMETHODS

new: options
	^ self fromJs: INLINE 'new electron$.MenuItem( options.js )'.
!

METHODS

"Writable properties"

id
	^ String fromJs: INLINE 'this.js.id'.
!
id: id
	INLINE 'this.js.id = id.js'.
!
label
	^ String fromJs: INLINE 'this.js.label'.
!
label: label
	INLINE 'this.js.label = label.js'.
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
checked
	"Note: Only meaningful for items of type 'checkbox' or 'radio'."
	^ Boolean fromJs: INLINE 'this.js.checked'.
!
checked: checked
	INLINE 'this.js.checked = checked.js'.
!
icon
	"Note: Only returns the icon if it was set as a file path string."
	^ String fromJs: INLINE '( typeof this.js.icon === "string" ? this.js.icon : null )'.
!
icon: path
	INLINE 'this.js.icon = path.js'.
!

"Read-only properties"

type
	"One of: 'normal', 'separator', 'submenu', 'checkbox', 'radio'."
	^ String fromJs: INLINE 'this.js.type'.
!
role
	"Returns nil if no role is set."
	^ String fromJs: INLINE 'this.js.role'.
!
accelerator
	"Returns nil if no accelerator is set."
	^ String fromJs: INLINE 'this.js.accelerator'.
!
commandId
	^ Integer fromJs: INLINE 'this.js.commandId'.
!
menu
	"The menu this item is part of."
	^ ElectronMenu fromJs: INLINE 'this.js.menu'.
!
submenu
	"Returns nil if the item has no submenu."
	^ ElectronMenu fromJs: INLINE 'this.js.submenu'.
!

"Events"

click: block
	"Note: The block receives the JS arguments: event, focusedWindow, focusedWebContents."
	INLINE 'this.js.click = block.js'.
!
