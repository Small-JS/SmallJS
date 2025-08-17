CLASS TestNwMenu EXTENDS Test MODULE TestNwjs CLASSVARS '' VARS ''

test
	| menu menuItem |

	menu := NwMenu newMenuBar.
	self assert: [ menu class = NwMenu ].
	self assert: [ menu type = 'menubar' ].

	menu := NwMenu new.
	self assert: [ menu class = NwMenu ].
	self assert: [ menu type = 'contextmenu' ].
	self assert: [ menu items length = 0 ].

	menuItem := NwMenuItem new: 'Edit'.
	menu append: menuItem.
	self assert: [ menu items length = 1 ].
	self assert: [ menu items first label = 'Edit' ].
	menu remove: menuItem.
	self assert: [ menu items length = 0 ].

	menuItem := NwMenuItem new: 'Item2'.
	menu append: menuItem.
	menuItem := NwMenuItem new: 'Item1'.
	menu insert: menuItem at: 0.
	self assert: [ menu items length = 2 ].
	self assert: [ menu items first label = 'Item1' ].
	menu removeAt: 0.
	self assert: [ menu items length = 1 ].
	self assert: [ menu items first label = 'Item2' ].
!

