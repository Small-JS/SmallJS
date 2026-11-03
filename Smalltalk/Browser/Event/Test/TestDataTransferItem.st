CLASS TestDataTransferItem EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

async testString
	| item string |
	item := DataTransfer new items add: 'Hello' type: 'text/plain'.
	self assert: [ item kind = 'string' ].
	self assert: [ item type = 'text/plain' ].
	self assert: [ item asFile isNil ].
	string := await item asString.
	self assert: [ string = 'Hello' ].
!
async testStringThen
	| item receiving string |
	item := DataTransfer new items add: 'Hello' type: 'text/plain'.
	receiving := Promise new: [ :resolve :reject |
		item asStringThen: [ :itemString |
			string := itemString.
			resolve value: nil ] ].
	await receiving js.
	self assert: [ string = 'Hello' ].
!
testFile
	| options file item |
	options := FileCreateOptions new type: 'text/plain'.
	file := File fromArray: #( 'Hello' ) name: 'hello.txt' options: options.
	item := DataTransfer new items addFile: file.
	self assert: [ item kind = 'file' ].
	self assert: [ item type = 'text/plain' ].
	self assert: [ item asFile class = File ].
	self assert: [ item asFile name = 'hello.txt' ].
!
