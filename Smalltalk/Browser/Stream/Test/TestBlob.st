CLASS TestBlob EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| blob |
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).

	self assert: [ blob size = 4 ].
	self assert: [ blob type = '' ].
	self assert: [ ( blob slice: 1 to: 3 ) size = 2 ].
!
testStream
	| blob stream |
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).

	self assert: [ blob size = 4 ].
	self assert: [ blob type = '' ].
	self assert: [ blob stream class = ReadableStream ].
	blob arrayBufferThen: [ :arrayBuffer | self onArrayBuffer: arrayBuffer ].
	blob textThen: [ :string | self onText: string ]
!
onText: string
	self assert: [ string = '4567' ].
!
onArrayBuffer: arrayBuffer
	self assert: [ arrayBuffer byteLength = 4 ].
	self assert: [ ( ArrayBuffer isView: arrayBuffer ) not ].
!
