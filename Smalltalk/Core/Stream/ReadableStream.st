CLASS ReadableStream EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

"Properties"

locked
	^ Boolean fromJs: INLINE 'this.js.locked'.
!

"Methods"

async cancel
	INLINE 'await this.js.cancel()'.
!
async cancel: reason
	INLINE 'await this.js.cancel( reason.js )'.
!
cancelThen: block
	INLINE 'this.js.cancel().then( () => block.js() )'.
!
cancelThen: thenBlock catch: catchBlock
	INLINE 'this.js.cancel()
		.then( () => thenBlock.js() )
		.catch( ( error ) => catchBlock.js( stError$class.$fromJs$( error ) ) )'.
!
getReader
	^ ReadableStreamDefaultReader fromJs: INLINE 'this.js.getReader()'.
!
getByobReader
	"Returns a reader that reads into a buffer provided by the caller.
	 Only available for byte streams, e.g. the stream of a Blob."
	^ ReadableStreamByobReader fromJs: INLINE 'this.js.getReader( { mode: "byob" } )'.
!
pipeThrough: transformStream
	^ ReadableStream fromJs: INLINE 'this.js.pipeThrough( transformStream.js )'.
!
pipeThrough: transformStream options: options
	^ ReadableStream fromJs: INLINE 'this.js.pipeThrough( transformStream.js, options.js )'.
!
async pipeTo: writableStream
	INLINE 'await this.js.pipeTo( writableStream.js )'.
!
async pipeTo: writableStream options: options
	INLINE 'await this.js.pipeTo( writableStream.js, options.js )'.
!
tee
	^ Array fromJs: INLINE 'this.js.tee()' elementClass: ReadableStream.
!
