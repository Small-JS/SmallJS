CLASS TestDataTransfer EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| dataTransfer |
	dataTransfer := DataTransfer new.
	self assert: [ dataTransfer class = DataTransfer ].
	self assert: [ dataTransfer jsClassName = 'DataTransfer' ].
	self assert: [ dataTransfer dropEffect = 'none' ].
	self assert: [ dataTransfer effectAllowed = 'none' ].
	self assert: [ dataTransfer types isEmpty ].
	self assert: [ dataTransfer files isEmpty ].
	self assert: [ dataTransfer items length = 0 ].
!
testEffects
	"Outside of drag events, browsers may ignore setting the effects, like Chrome does."
	| dataTransfer |
	dataTransfer := DataTransfer new.
	dataTransfer dropEffect: 'copy'; effectAllowed: 'copyMove'.
	self assert: [ #( 'none' 'copy' ) includes: dataTransfer dropEffect ].
	self assert: [ #( 'none' 'copyMove' ) includes: dataTransfer effectAllowed ].
!
testData
	| dataTransfer |
	dataTransfer := DataTransfer new.
	dataTransfer setData: 'text/plain' value: 'Hello'.
	dataTransfer setData: 'text/html' value: '<b>Hello</b>'.
	self assert: [ dataTransfer types = #( 'text/plain' 'text/html' ) ].
	self assert: [ ( dataTransfer getData: 'text/plain' ) = 'Hello' ].
	self assert: [ ( dataTransfer getData: 'text/html' ) = '<b>Hello</b>' ].
	self assert: [ ( dataTransfer getData: 'text/uri-list' ) = '' ].

	dataTransfer setData: 'text/plain' value: 'Replaced'.
	self assert: [ ( dataTransfer getData: 'text/plain' ) = 'Replaced' ].
	self assert: [ dataTransfer types length = 2 ].

	dataTransfer clearData: 'text/html'.
	self assert: [ dataTransfer types = #( 'text/plain' ) ].
	dataTransfer clearData.
	self assert: [ dataTransfer types isEmpty ].
!
testFiles
	| dataTransfer options file |
	dataTransfer := DataTransfer new.
	options := FileCreateOptions new type: 'text/plain'.
	file := File fromArray: #( 'Hello' ) name: 'hello.txt' options: options.
	dataTransfer items addFile: file.
	self assert: [ dataTransfer files length = 1 ].
	self assert: [ dataTransfer files first class = File ].
	self assert: [ dataTransfer files first name = 'hello.txt' ].
	self assert: [ dataTransfer types = #( 'Files' ) ].
	"Clearing data does not remove files."
	dataTransfer clearData.
	self assert: [ dataTransfer files length = 1 ].
!
testDragImage
	| dataTransfer div |
	dataTransfer := DataTransfer new.
	div := Document new createElement: 'div'.
	"Outside of 'dragstart' this has no effect, but it must not fail."
	dataTransfer setDragImage: div offset: 10 @ 20.
	self assert: [ dataTransfer types isEmpty ].
!
