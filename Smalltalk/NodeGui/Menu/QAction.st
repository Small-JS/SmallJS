CLASS QAction EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QAction } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QAction()'.
!

METHODS

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	self error: 'QAction.text() not implemented in NodeGui yet (5-OCT-2024).'
	"^ String fromJs: INLINE 'this.js.text()'."
!
