CLASS TestWritableStreamDefaultWriter EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

async testWrite
	| sink writable writer |
	sink := self newSink.
	writable := self newWritable: sink.
	writer := writable getWriter.
	self assert: [ writer class = WritableStreamDefaultWriter ].
	self assert: [ writable locked ].
	"The default high water mark is 1 chunk."
	self assert: [ writer desiredSize = 1 ].

	await writer ready.
	await writer write: ( Uint8Array from: #( 1 2 3 ) ).
	await writer write: ( Uint8Array from: #( 4 ) ).
	self assert: [ ( Integer fromJs: INLINE 'sink.js.bytes' ) = 4 ].
	self assert: [ ( Boolean fromJs: INLINE 'sink.js.closed' ) not ].

	await writer close.
	await writer closed.
	self assert: [ Boolean fromJs: INLINE 'sink.js.closed' ].
	self assert: [ writer desiredSize = 0 ].
!
async testAbort
	| sink writer |
	sink := self newSink.
	writer := ( self newWritable: sink ) getWriter.
	await writer abort.
	self assert: [ Boolean fromJs: INLINE 'sink.js.aborted' ].
	self assert: [ ( Boolean fromJs: INLINE 'sink.js.closed' ) not ].

	sink := self newSink.
	writer := ( self newWritable: sink ) getWriter.
	await writer abort: 'No longer needed'.
	self assert: [ ( String fromJs: INLINE 'sink.js.reason' ) = 'No longer needed' ].
!
testReleaseLock
	| writable writer |
	writable := self newWritable: self newSink.
	writer := writable getWriter.
	self assert: [ writable locked ].
	writer releaseLock.
	self assert: [ writable locked not ].
	"A new writer can be obtained after releasing the lock."
	self assert: [ writable getWriter class = WritableStreamDefaultWriter ].
!

"Helpers"

newSink
	"JS object that records what a WritableStream receives."
	^ JsObject fromJs: INLINE '{ bytes: 0, closed: false, aborted: false, reason: null }'.
!
newWritable: sink
	^ WritableStream fromJs: INLINE 'new WritableStream( {
		write( chunk ) { sink.js.bytes += chunk.byteLength },
		close() { sink.js.closed = true },
		abort( reason ) { sink.js.aborted = true; sink.js.reason = reason } } )'.
!
