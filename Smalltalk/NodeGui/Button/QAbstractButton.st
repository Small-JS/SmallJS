CLASS QAbstractButton EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QAbstractButton } from "@nodegui/nodegui";'

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	^ String fromJs: INLINE 'this.js.text()'.
!
