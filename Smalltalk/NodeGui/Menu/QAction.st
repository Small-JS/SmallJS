CLASS QAction EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QAction()'.
!

METHODS

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	self error: 'QAction.text() not implemented in NodeGui yet (5-OCT-2024).'
	"^ String fromJs: INLINE 'this.js.text()'."
!
