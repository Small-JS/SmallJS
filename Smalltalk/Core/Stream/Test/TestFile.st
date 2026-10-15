CLASS TestFile EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| before file |
	before := Date now.
	file := File fromArray: ( Uint8Array from: #( 4 5 6 7 ) ) name: 'test.bin'.

	self assert: [ file class = File ].
	self assert: [ file size = 4 ].
	self assert: [ file type = '' ].
	self assert: [ file name = 'test.bin' ].
	"Without options, lastModified is the creation time."
	self assert: [ file lastModified >= before ].
	self assert: [ file lastModified <= Date now ].
	"A File is a Blob."
	self assert: [ file isKindOf: Blob ].
	self assert: [ ( file slice: 1 to: 3 ) size = 2 ].
!
testOptions
	| file |
	file := File fromArray: #( 'Hello' ' ' 'world' ) name: 'hello.txt'
		options: ( FileCreateOptions new type: 'text/plain'; lastModified: 1000 ).

	self assert: [ file class = File ].
	self assert: [ file size = 11 ].
	self assert: [ file type = 'text/plain' ].
	self assert: [ file name = 'hello.txt' ].
	self assert: [ file lastModified = 1000 ].
	file textThen: [ :string | self onText: string ].
!
testEndings
	| lines file |
	lines := String fromJs: INLINE '"a\nb"'.

	"Transparent (default) keeps line endings as they are."
	file := File fromArray: ( Array with: lines ) name: 'lines.txt'
		options: ( FileCreateOptions new endings: 'transparent' ).
	self assert: [ file size = 3 ].

	"Native converts line endings to those of the OS: \n or \r\n."
	file := File fromArray: ( Array with: lines ) name: 'lines.txt'
		options: ( FileCreateOptions new endings: 'native' ).
	self assert: [ file size = 3 | ( file size = 4 ) ].
!
onText: string
	self assert: [ string = 'Hello world' ].
!
