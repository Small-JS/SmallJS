CLASS QMenuBar EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QMenuBar } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QMenuBar()'.
!

METHODS

addMenu: menu
	INLINE 'this.js.addMenu( menu.js )'.
!

