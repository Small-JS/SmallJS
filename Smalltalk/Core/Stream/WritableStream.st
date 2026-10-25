CLASS WritableStream EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

"Properties"

locked
	^ Boolean fromJs: INLINE 'this.js.locked'.
!

"Methods"

async abort
	INLINE 'await this.js.abort()'.
!
async abort: reason
	INLINE 'await this.js.abort( reason.js )'.
!
async close
	"Closes the stream after all queued chunks are written."
	INLINE 'await this.js.close()'.
!
getWriter
	^ WritableStreamDefaultWriter fromJs: INLINE 'this.js.getWriter()'.
!
