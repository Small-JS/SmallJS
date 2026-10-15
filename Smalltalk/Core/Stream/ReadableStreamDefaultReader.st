CLASS ReadableStreamDefaultReader EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

"Properties"

async closed
	"Returns when the stream is closed."
	INLINE 'await this.js.closed'.
!

"Methods"

async cancel
	INLINE 'await this.js.cancel()'.
!
async cancel: reason
	INLINE 'await this.js.cancel( reason.js )'.
!
async read
	"Returns the next chunk of the stream as a ReadableStreamReadResult."
	^ ReadableStreamReadResult fromJs: INLINE 'await this.js.read()'.
!
