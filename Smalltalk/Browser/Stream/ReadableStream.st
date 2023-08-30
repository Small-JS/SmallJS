CLASS ReadableStream EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''

METHODS

"Properties"

locked
	^ Boolean fromJs: INLINE 'this.js.locked'.
!

cancelThen: block
	INLINE 'this.js.cancel().then( block.js )'.
!

"Methods"

getReader
	^ ReadableStreamDefaultReader fromJs: INLINE 'this.js.getReader()'.
!
pipeThrough: transformStream options: options
	^ ReadableStream fromJs: INLINE 'this.js.pipeThrough( transformStream.js, options.js )'.
!
pipeTo: writeableStream options: options then: block
	INLINE 'this.js.pipeTo( writeableStream.js, options.js ).then( block.js )'.
!
tee
	^ Array fromJs: INLINE 'this.js.tee()' elementClass: ReadableStream.
!
