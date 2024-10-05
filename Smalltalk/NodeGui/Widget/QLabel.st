CLASS QLabel EXTENDS QFrame MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QLabel } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QLabel()'.
!

METHODS

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	^ String fromJs: INLINE 'this.js.text()'.
!
setPixmap: pixmap
	INLINE 'this.js.setPixmap( pixmap.js )'.
!
