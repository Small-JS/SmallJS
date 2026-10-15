CLASS TestWritableStream EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| writable |
	writable := self newWritable: self newSink.
	self assert: [ writable class = WritableStream ].
	self assert: [ writable locked not ].
	self assert: [ writable getWriter class = WritableStreamDefaultWriter ].
	self assert: [ writable locked ].
!
async testAbort
	| sink |
	sink := self newSink.
	await ( self newWritable: sink ) abort.
	self assert: [ Boolean fromJs: INLINE 'sink.js.aborted' ].

	sink := self newSink.
	await ( self newWritable: sink ) abort: 'No longer needed'.
	self assert: [ Boolean fromJs: INLINE 'sink.js.aborted' ].
	self assert: [ ( String fromJs: INLINE 'sink.js.reason' ) = 'No longer needed' ].
!

"Helpers"

newSink
	"JS object that records what a WritableStream receives."
	^ JsObject fromJs: INLINE '{ aborted: false, reason: null }'.
!
newWritable: sink
	^ WritableStream fromJs: INLINE 'new WritableStream( {
		abort( reason ) { sink.js.aborted = true; sink.js.reason = reason } } )'.
!
