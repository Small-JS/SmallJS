CLASS WritableStreamDefaultWriter EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

"Properties"

async closed
	"Returns when the stream is closed."
	INLINE 'await this.js.closed'.
!
desiredSize
	^ Integer fromJs: INLINE 'this.js.desiredSize'.
!
async ready
	"Returns when the desired size of the stream becomes positive."
	INLINE 'await this.js.ready'.
!

"Methods"

async abort
	INLINE 'await this.js.abort()'.
!
async abort: reason
	INLINE 'await this.js.abort( reason.js )'.
!
async close
	INLINE 'await this.js.close()'.
!
releaseLock
	INLINE 'this.js.releaseLock()'.
!
async write: chunk
	INLINE 'await this.js.write( chunk.js )'.
!
