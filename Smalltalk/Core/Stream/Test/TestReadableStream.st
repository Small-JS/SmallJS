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
	self newStream cancelThen: [ self onCancel ] catch: [ :error | self assert: [ false ] ].

	"Canceling a locked stream fails."
	stream := self newStream.
	stream getReader.
	stream cancelThen: [ self assert: [ false ] ] catch: [ :error | self onCancelError: error ].
!
onCancel
	self assert: [ true ].
!
onCancelError: error
	self assert: [ error class = Error ].
!
async testCancel
	| stream reader result |
	stream := self newStream.
	await stream cancel.
	reader := stream getReader.
	result := await reader read.
	self assert: [ result done ].

	stream := self newStream.
	await stream cancel: 'No longer needed'.
	result := await stream getReader read.
	self assert: [ result done ].
!
async testByobReader
	| stream reader result |
	stream := self newStream.
	reader := stream getByobReader.
	self assert: [ reader class = ReadableStreamByobReader ].
	self assert: [ stream locked ].

	result := await reader read: ( Uint8Array new: 8 ) min: 4.
	self assert: [ result done not ].
	self assert: [ result value toArray = #( 4 5 6 7 ) ].

	result := await reader read: ( Uint8Array new: 8 ).
	self assert: [ result done ].
	await reader closed.

	reader releaseLock.
	self assert: [ stream locked not ].

	stream := self newStream.
	reader := stream getByobReader.
	await reader cancel: 'No longer needed'.
	result := await reader read: ( Uint8Array new: 8 ).
	self assert: [ result done ].

	reader := self newStream getByobReader.
	await reader cancel.
	result := await reader read: ( Uint8Array new: 8 ).
	self assert: [ result done ].
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

	"Without options."
	sink := self newSink.
	await self newStream pipeTo: ( self newWritable: sink ).
	self assert: [ ( Integer fromJs: INLINE 'sink.js.bytes' ) = 4 ].
	self assert: [ Boolean fromJs: INLINE 'sink.js.closed' ].
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

	"Without options."
	transform := JsObject fromJs: INLINE 'new TransformStream()'.
	piped := self newStream pipeThrough: transform.
	sink := self newSink.
	await piped pipeTo: ( self newWritable: sink ).
	self assert: [ ( Integer fromJs: INLINE 'sink.js.bytes' ) = 4 ].
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
