CLASS QPushButton EXTENDS QAbstractButton MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QPushButton()'.
!

METHODS

"Default button"

setDefault: isDefault
	"The default button of a dialog is clicked when the user presses Enter."
	INLINE 'this.js.setDefault( isDefault.js )'.
!
isDefault
	^ Boolean fromJs: INLINE 'this.js.isDefault()'.
!
setAutoDefault: autoDefault
	"An auto default button becomes the default button when it gets the focus."
	INLINE 'this.js.setAutoDefault( autoDefault.js )'.
!
autoDefault
	^ Boolean fromJs: INLINE 'this.js.autoDefault()'.
!

"Appearance"

setFlat: isFlat
	"A flat button has no border, unless it is pressed."
	INLINE 'this.js.setFlat( isFlat.js )'.
!
isFlat
	^ Boolean fromJs: INLINE 'this.js.isFlat()'.
!

"Menu"

setMenu: menu
	"Show menu when the button is pressed."
	INLINE 'this.js.setMenu( menu.js )'.
!
menu
	"Answer nil if there is no menu."
	^ QMenu fromJs: INLINE 'this.js.menu()'.
!
showMenu
	"Show the menu of the button. Waits until the user closes the menu."
	INLINE 'this.js.showMenu()'.
!
