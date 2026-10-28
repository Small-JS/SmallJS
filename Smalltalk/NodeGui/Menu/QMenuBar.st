CLASS QMenuBar EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QMenuBar()'.
!

METHODS

addMenu: menu
	INLINE 'this.js.addMenu( menu.js )'.
!

