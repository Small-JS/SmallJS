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
getWriter
	^ WritableStreamDefaultWriter fromJs: INLINE 'this.js.getWriter()'.
!
