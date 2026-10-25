CLASS TestBlob EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| blob |
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).

	self assert: [ blob size = 4 ].
	self assert: [ blob type = '' ].
	self assert: [ ( blob slice: 1 to: 3 ) size = 2 ].
	self assert: [ ( blob slice: 1 ) size = 3 ].
	self assert: [ ( blob slice: 1 to: 3 type: 'text/plain' ) type = 'text/plain' ].
!
testParts
	| blob |
	"A single typed array part is stored as bytes, not as decimal strings."
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 100 ) ).
	self assert: [ blob size = 5 ].

	"An Array of parts can mix Strings, typed arrays and Blobs."
	blob := Blob fromArray: ( Array new
		add: 'ab'; add: ( Uint8Array encodeFromString: 'cd' ); add: ( Blob fromArray: 'ef' ); yourself ).
	self assert: [ blob size = 6 ].
	blob textThen: [ :string | self onPartsText: string ].
!
onPartsText: string
	self assert: [ string = 'abcdef' ].
!
testOptions
	| blob |
	blob := Blob fromArray: #( 'Hello' ) options: ( BlobCreateOptions new type: 'text/plain' ).
	self assert: [ blob type = 'text/plain' ].
	self assert: [ blob size = 5 ].
!
testStream
	| blob |
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).

	self assert: [ blob stream class = ReadableStream ].
	self assert: [ ( blob arrayBufferThen: [ :arrayBuffer | self onArrayBuffer: arrayBuffer ] ) = blob ].
	blob arrayBufferThen: [ :arrayBuffer | self onArrayBuffer: arrayBuffer ]
		catch: [ :error | self assert: [ false ] ].
	blob bytesThen: [ :bytes | self onBytes: bytes ].
	blob bytesThen: [ :bytes | self onBytes: bytes ]
		catch: [ :error | self assert: [ false ] ].
	( Blob fromArray: 'Text' ) textThen: [ :string | self onText: string ].
	( Blob fromArray: 'Text' ) textThen: [ :string | self onText: string ]
		catch: [ :error | self assert: [ false ] ].
!
onText: string
	self assert: [ string = 'Text' ].
!
onArrayBuffer: arrayBuffer
	self assert: [ arrayBuffer class = ArrayBuffer ].
	self assert: [ arrayBuffer byteLength = 4 ].
	self assert: [ ( ArrayBuffer isView: arrayBuffer ) not ].
!
onBytes: bytes
	self assert: [ bytes class = Uint8Array ].
	self assert: [ bytes toArray = #( 4 5 6 7 ) ].
!
async testAsync
	| blob arrayBuffer bytes text |
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).

	arrayBuffer := await blob arrayBuffer.
	self assert: [ arrayBuffer class = ArrayBuffer ].
	self assert: [ arrayBuffer byteLength = 4 ].

	bytes := await blob bytes.
	self assert: [ bytes class = Uint8Array ].
	self assert: [ bytes toArray = #( 4 5 6 7 ) ].

	text := await ( Blob fromArray: #( 'Hello' ' ' 'world' ) ) text.
	self assert: [ text = 'Hello world' ].
!
