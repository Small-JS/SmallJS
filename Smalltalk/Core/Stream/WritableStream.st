CLASS WritableStream EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

"Properties"

locked
	^ Boolean fromJs: INLINE 'this.js.locked'.
!

"Methods"

abort
	^ ReadableStreamDefaultReader fromJs: INLINE 'this.js.abort()'.
!
getWriter
	^ ReadableStreamDefaultWriter fromJs: INLINE 'this.js.getWriter()'.
!
