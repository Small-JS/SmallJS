CLASS TestDragEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := DragEvent type: 'dragstart'.
	self assert: [ event class = DragEvent ].
	self assert: [ event type = 'dragstart' ].
	self assert: [ event dataTransfer isNil ].
	"Inherited from MouseEvent"
	self assert: [ event client = ( 0 @ 0 ) ].
!
testOptions
	| dataTransfer options event |
	dataTransfer := DataTransfer new.
	dataTransfer setData: 'text/plain' value: 'Dragged'.
	options := DragEventOptions new dataTransfer: dataTransfer; client: 10 @ 20; bubbles: true.
	event := DragEvent type: 'drop' options: options.
	self assert: [ event class = DragEvent ].
	self assert: [ event type = 'drop' ].
	self assert: [ event dataTransfer = dataTransfer ].
	self assert: [ event dataTransfer class = DataTransfer ].
	self assert: [ ( event dataTransfer getData: 'text/plain' ) = 'Dragged' ].
	"Inherited options"
	self assert: [ event client = ( 10 @ 20 ) ].
	self assert: [ event bubbles ].
!
testListener
	| div options received |
	div := Document new createElement: 'div'.
	div addEventListener: 'dragover' then: [ :event | received := event ].
	options := DragEventOptions new dataTransfer: DataTransfer new.
	div dispatchEvent: ( DragEvent type: 'dragover' options: options ).
	self assert: [ received class = DragEvent ].
	self assert: [ received dataTransfer class = DataTransfer ].
!
