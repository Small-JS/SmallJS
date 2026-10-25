CLASS TestReadableStreamDefaultReader EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

async testRead
	| reader result |
	reader := self newStream getReader.
	result := await reader read.
	self assert: [ result class = ReadableStreamReadResult ].
	self assert: [ result done not ].
	self assert: [ result value class = Uint8Array ].
	self assert: [ result value byteLength > 0 ].
!
async testReadAll
	| reader result bytes |
	reader := self newStream getReader.
	"The data can arrive in multiple chunks."
	bytes := 0.
	result := await reader read.
	await [ result done not ] whileTrueAwait: async [
		bytes := bytes + result value byteLength.
		result := await reader read ].
	self assert: [ bytes = 4 ].
	self assert: [ result done ].
	self assert: [ result value isNil ].

	"Closed returns because the stream has ended."
	await reader closed.
	result := await reader read.
	self assert: [ result done ].
!
async testCancel
	| stream reader result |
	stream := self newStream.
	reader := stream getReader.
	await reader cancel.
	await reader closed.
	result := await reader read.
	self assert: [ result done ].
	self assert: [ stream locked ].

	reader := self newStream getReader.
	await reader cancel: 'No longer needed'.
	result := await reader read.
	self assert: [ result done ].
!
async testReleaseLock
	| stream reader result |
	stream := self newStream.
	reader := stream getReader.
	self assert: [ stream locked ].
	reader releaseLock.
	self assert: [ stream locked not ].

	"A new reader can be obtained after releasing the lock."
	reader := stream getReader.
	result := await reader read.
	self assert: [ result done not ].
!

"Helpers"

newStream
	^ ( Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ) ) stream.
!
