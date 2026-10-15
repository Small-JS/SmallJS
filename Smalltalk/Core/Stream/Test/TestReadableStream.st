CLASS TestReadableStream EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| stream streamTee |
	stream := self newStream.
	self assert: [ stream class = ReadableStream ].
	self assert: [ stream locked not ].
	self assert: [ stream getReader class = ReadableStreamDefaultReader ].
	self assert: [ stream locked ].

	stream := self newStream.
	streamTee := stream tee.
	self assert: [ streamTee first class = ReadableStream ].
	streamTee first cancelThen: [ self onCancel ].
!
onCancel
	self assert: [ true ].
!
async testTee
	| stream streamTee bytes |
	stream := self newStream.
	streamTee := stream tee.
	self assert: [ stream locked ].
	self assert: [ streamTee length = 2 ].
	self assert: [ streamTee first class = ReadableStream ].
	self assert: [ streamTee last class = ReadableStream ].
	self assert: [ streamTee first locked not ].
	self assert: [ streamTee last locked not ].

	"Both branches read all data."
	bytes := await self readBytes: streamTee first.
	self assert: [ bytes = 4 ].
	bytes := await self readBytes: streamTee last.
	self assert: [ bytes = 4 ].
!
async testPipeTo
	| stream sink writable |
	stream := self newStream.
	sink := self newSink.
	writable := self newWritable: sink.
	self assert: [ writable locked not ].

	await stream pipeTo: writable options: JsObject newEmpty.
	self assert: [ ( Integer fromJs: INLINE 'sink.js.bytes' ) = 4 ].
	"By default the destination is closed when the source ends."
	self assert: [ Boolean fromJs: INLINE 'sink.js.closed' ].
	self assert: [ stream locked not ].
	self assert: [ writable locked not ].
!
async testPipeToPreventClose
	| stream sink writable |
	stream := self newStream.
	sink := self newSink.
	writable := self newWritable: sink.

	await stream pipeTo: writable options: ( JsObject fromJs: INLINE '{ preventClose: true }' ).
	self assert: [ ( Integer fromJs: INLINE 'sink.js.bytes' ) = 4 ].
	self assert: [ ( Boolean fromJs: INLINE 'sink.js.closed' ) not ].
!
async testPipeThrough
	| stream transform piped sink |
	stream := self newStream.
	"Transform that emits each chunk twice."
	transform := JsObject fromJs: INLINE 'new TransformStream( {
		transform( chunk, controller ) { controller.enqueue( chunk ); controller.enqueue( chunk ) } } )'.

	piped := stream pipeThrough: transform options: JsObject newEmpty.
	self assert: [ piped class = ReadableStream ].
	self assert: [ stream locked ].
	self assert: [ piped locked not ].

	sink := self newSink.
	await piped pipeTo: ( self newWritable: sink ) options: JsObject newEmpty.
	self assert: [ ( Integer fromJs: INLINE 'sink.js.bytes' ) = 8 ].
	self assert: [ Boolean fromJs: INLINE 'sink.js.closed' ].
!

"Helpers"

newStream
	^ ( Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ) ) stream.
!
async readBytes: stream
	"Read until done and return the number of bytes, the data can arrive in multiple chunks."
	| reader result bytes |
	reader := stream getReader.
	bytes := 0.
	result := await reader read.
	await [ result done not ] whileTrueAwait: async [
		bytes := bytes + result value byteLength.
		result := await reader read ].
	^ bytes.
!
newSink
	"JS object that records what a WritableStream receives."
	^ JsObject fromJs: INLINE '{ bytes: 0, closed: false }'.
!
newWritable: sink
	^ WritableStream fromJs: INLINE 'new WritableStream( {
		write( chunk ) { sink.js.bytes += chunk.byteLength },
		close() { sink.js.closed = true } } )'.
!
