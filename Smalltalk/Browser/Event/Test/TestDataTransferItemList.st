CLASS TestDataTransferItemList EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testAdd
	| dataTransfer items item file |
	dataTransfer := DataTransfer new.
	items := dataTransfer items.
	self assert: [ items class = DataTransferItemList ].
	self assert: [ items length = 0 ].
	self assert: [ ( items at: 0 ) isNil ].

	item := items add: 'Hello' type: 'text/plain'.
	self assert: [ item class = DataTransferItem ].
	self assert: [ items length = 1 ].
	self assert: [ ( dataTransfer getData: 'text/plain' ) = 'Hello' ].
	"Adding data of an existing type throws a JS DOMException."
	self assert: [ ( [ items add: 'Again' type: 'text/plain' ] tryCatch: [ :error | error name ] ) = 'NotSupportedError' ].

	file := File fromArray: #( 'Hello' ) name: 'hello.txt'.
	item := items addFile: file.
	self assert: [ item kind = 'file' ].
	self assert: [ items length = 2 ].
	self assert: [ ( items at: 1 ) kind = 'file' ].
	self assert: [ ( items toArray map: [ :each | each kind ] ) = #( 'string' 'file' ) ].
!
testRemove
	| dataTransfer items |
	dataTransfer := DataTransfer new.
	items := dataTransfer items.
	items add: 'Hello' type: 'text/plain'.
	items add: '<b>Hello</b>' type: 'text/html'.
	items remove: 0.
	self assert: [ items length = 1 ].
	self assert: [ dataTransfer types = #( 'text/html' ) ].
	items clear.
	self assert: [ items length = 0 ].
	self assert: [ items toArray isEmpty ].
!
