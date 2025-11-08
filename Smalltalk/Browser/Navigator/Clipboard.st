CLASS Clipboard EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"TODO: Implement other methods"

CLASSMETHODS

default
	"Return the clipboard singleton."
	^ Window default navigator clipboard.
!

METHODS

async readText
	^ String fromJs: INLINE 'await this.js.readText()'.
!
async writeText: text
	INLINE 'await this.js.writeText( text.js )'
!
