CLASS ReadableStreamDefaultWriter EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

"Properties"

closedThen: block
	INLINE 'this.js.closed.then( block.js )'.
!
desiredSize
	^ Integer fromJs: INLINE 'this.js.desiredSize'.
!
readyThen: block
	INLINE 'this.js.ready.then( block.js )'.
!

"Methods"

abortThen: block
	INLINE 'this.js.abort().then( block.js )'.
!
closeThen: block
	INLINE 'this.js.close().then( block.js )'.
!
releaseLock
	INLINE 'this.js.releaseLock()'.
!
write: chunk then: block
	INLINE 'this.js.write( chunk.js ).then( block.js )'.
!
