CLASS ElectronMenuItemOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Partially implements Electron JS interface: MenuItemConstructorOptions."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Properties"

role
	^ String new: INLINE 'this.js.role'.
!
role: role
	INLINE 'this.js.role = role.js'.
!
type
	^ String new: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
label
	^ String new: INLINE 'this.js.label'.
!
label: label
	INLINE 'this.js.label = label.js'.
!
subLabel
	^ String new: INLINE 'this.js.subLabel'.
!
subLabel: subLabel
	INLINE 'this.js.subLabel = subLabel.js'.
!
toolTip
	^ String new: INLINE 'this.js.toolTip'.
!
toolTip: toolTip
	INLINE 'this.js.toolTip = toolTip.js'.
!
accelerator
	^ String new: INLINE 'this.js.accelerator'.
!
accelerator: accelerator
	INLINE 'this.js.accelerator = accelerator.js'.
!
enabled
	^ Boolean new: INLINE 'this.js.enabled'.
!
enabled: enabled
	INLINE 'this.js.enabled = enabled.js'.
!
visible
	^ Boolean new: INLINE 'this.js.visible'.
!
visible: visible
	INLINE 'this.js.visible = visible.js'.
!
submenu
	^ Boolean new: INLINE 'this.js.submenu'.
!
submenu: submenu
	INLINE 'this.js.submenu = submenu.js'.
!

"Events"

click: block
	INLINE 'this.js.click = block.js'.
!
