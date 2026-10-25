CLASS ReadableStreamByobReader EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

"Encapsulates a JS ReadableStreamBYOBReader ('Bring Your Own Buffer').
 It reads from a byte stream into a Uint8Array provided by the caller."

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
async read: view
	"Reads the next chunk into the Uint8Array view, and returns a ReadableStreamReadResult.
	 The buffer of view is transferred: use the value of the result instead of view after reading."
	^ ReadableStreamReadResult fromJs: INLINE 'await this.js.read( view.js )'.
!
async read: view min: min
	"Like read:, but waits until at least min bytes are available, or the stream ends."
	^ ReadableStreamReadResult fromJs: INLINE 'await this.js.read( view.js, { min: min.js } )'.
!
releaseLock
	"Unlocks the stream, so a new reader can be obtained."
	INLINE 'this.js.releaseLock()'.
!
