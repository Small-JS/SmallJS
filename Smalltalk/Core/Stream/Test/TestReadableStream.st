CLASS TestReadableStream EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| stream streamTee |
	stream := ( Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ) ) stream.
	self assert: [ stream class = ReadableStream ].
	self assert: [ stream locked not ].
	self assert: [ stream getReader class = ReadableStreamDefaultReader ].
	self assert: [ stream locked ].

	stream := ( Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ) ) stream.
	streamTee := stream tee.
	self assert: [ streamTee first class = ReadableStream ].
	streamTee first cancelThen: [ self onCancel ].
!
onCancel
	self assert: [ true ].
!

"TODO:
- pipeThrough: transformStream options: options
- pipeTo: writeableStream options: options
- tee"
