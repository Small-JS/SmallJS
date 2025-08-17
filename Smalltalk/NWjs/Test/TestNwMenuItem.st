CLASS TestNwMenuItem EXTENDS Test MODULE TestNwjs CLASSVARS '' VARS ''

test
	| menuItem submenu |

	menuItem := NwMenuItem new: 'File'.
	self assert: [ menuItem type = 'normal' ].
	self assert: [ menuItem label = 'File' ].
	menuItem label: 'File2'.
	self assert: [ menuItem label = 'File2' ].

	self assert: [ menuItem submenu isNil ].
	submenu := NwMenu new.
	menuItem submenu: submenu.
	self assert: [ menuItem submenu = submenu ].

	self assert: [ menuItem icon = '' ].
	menuItem icon: 'icon.png'.
	self assert: [ menuItem icon = 'icon.png' ].

	self assert: [ menuItem tooltip = '' ].
	menuItem tooltip: 'My tooltip'.
	self assert: [ menuItem tooltip = 'My tooltip' ].

	self assert: [ menuItem click isNil ].
	menuItem click: [ self onMenuItemClick ].
	self assert: [ menuItem click notNil ].

	self assert: [ menuItem enabled ].
	menuItem enabled: false.
	self assert: [ menuItem enabled not ].

	self assert: [ menuItem key = '' ].
	"2025-08-14 Setting the menu item key crashes Nw.js on Windows:
	 This has been reported here: https://github.com/nwjs/nw.js/issues/8290
	menuItem key: 'F'.
	self assert: [ menuItem key = 'F1' ]."

	self assert: [ menuItem modifiers = '' ].
	"2025-08-14 Setting the menu item modifiers also crashes Nw.js on Windows:
	 This has been reported here: https://github.com/nwjs/nw.js/issues/8290
	menuItem modifiers: 'alt'.
	self assert: [ menuItem modifiers = 'alt' ]."

	"Checkbox"

	menuItem := NwMenuItem checkbox: 'Private'.
	self assert: [ menuItem type = 'checkbox' ].
	self assert: [ menuItem label = 'Private' ].

	self assert: [ menuItem checked not ].
	menuItem checked: true.
	self assert: [ menuItem checked ].

	"Separator"

	menuItem := NwMenuItem separator.
	self assert: [ menuItem type = 'separator' ].
!
