CLASS TestClipboardItem EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testSupports
	self assert: [ ClipboardItem supports: 'text/plain' ].
	self assert: [ ClipboardItem supports: 'text/html' ].
	self assert: [ ClipboardItem supports: 'image/png' ].
	self assert: [ ( ClipboardItem supports: 'unknown/type' ) not ].
!
async testTypeData
	| item blob |
	item := ClipboardItem type: 'text/plain' data: 'Hello'.
	self assert: [ item class = ClipboardItem ].
	self assert: [ item types = #( 'text/plain' ) ].

	blob := await item getType: 'text/plain'.
	self assert: [ blob class = Blob ].
	self assert: [ blob type = 'text/plain' ].
	self assert: [ blob size = 5 ].
!
async testTypesData
	| item blob |
	item := ClipboardItem
		types: #( 'text/plain' 'text/html' )
		data: #( 'Hello' '<b>Hello</b>' ).
	self assert: [ item types = #( 'text/plain' 'text/html' ) ].

	blob := await item getType: 'text/html'.
	self assert: [ blob type = 'text/html' ].
	self assert: [ blob size = 12 ].
!
async testBlobData
	| item blob |
	blob := Blob fromArray: ( Uint8Array from: #( 1 2 3 4 ) ).
	item := ClipboardItem type: 'image/png' data: blob.
	self assert: [ item types = #( 'image/png' ) ].

	blob := await item getType: 'image/png'.
	self assert: [ blob size = 4 ].
!
