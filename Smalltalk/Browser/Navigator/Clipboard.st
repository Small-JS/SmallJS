CLASS Clipboard EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: Clipboard.
	 Reading and writing may require user permission and a focused document."

CLASSMETHODS

default
	"Return the clipboard singleton."
	^ Window default navigator clipboard.
!

METHODS

async read
	"Return the clipboard contents as an Array of ClipboardItems."
	^ Array fromJs: INLINE 'await this.js.read()' elementClass: ClipboardItem.
!
async readText
	^ String fromJs: INLINE 'await this.js.readText()'.
!
async write: clipboardItems
	"Write an Array of ClipboardItems to the clipboard."
	INLINE 'await this.js.write( clipboardItems.$toJs() )'.
!
async writeText: text
	INLINE 'await this.js.writeText( text.js )'.
!
