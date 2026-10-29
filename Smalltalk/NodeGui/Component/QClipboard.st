CLASS QClipboard EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"The system clipboard, shared with other applications. Get it with QApplication clipboard.
 Changing it changes the clipboard of the user, so tests should restore it."

METHODS

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	"Answer an empty string if the clipboard holds no text."
	^ String fromJs: INLINE 'this.js.text()'.
!
setPixmap: pixmap
	INLINE 'this.js.setPixmap( pixmap.js )'.
!
pixmap
	"Answer an empty pixmap if the clipboard holds no image."
	^ QPixmap fromJs: INLINE 'this.js.pixmap( 0 )'.
!
clear
	INLINE 'this.js.clear()'.
!

"Events"

onDataChange: block
	"Block is called when the contents of the clipboard change, also by other applications."
	self addEventListener: 'dataChanged' then: [ block value ].
!
