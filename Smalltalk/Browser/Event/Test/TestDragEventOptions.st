CLASS TestDragEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options dataTransfer |
	options := DragEventOptions new.
	self assert: [ options class = DragEventOptions ].
	self assert: [ options dataTransfer isNil ].
	dataTransfer := DataTransfer new.
	options dataTransfer: dataTransfer.
	self assert: [ options dataTransfer = dataTransfer ].

	"Inherited options"
	options client: 5 @ 6; detail: 2.
	self assert: [ options client = ( 5 @ 6 ) ].
	self assert: [ options detail = 2 ].
!
