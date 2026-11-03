CLASS TestInputEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := InputEvent type: 'input'.
	self assert: [ event class = InputEvent ].
	self assert: [ event type = 'input' ].
	self assert: [ event data isNil ].
	self assert: [ event dataTransfer isNil ].
	self assert: [ event inputType = '' ].
	self assert: [ event isComposing not ].
	self assert: [ event targetRanges isEmpty ].
!
testOptions
	| dataTransfer options event |
	dataTransfer := DataTransfer new.
	dataTransfer setData: 'text/plain' value: 'Pasted'.
	options := InputEventOptions new
		data: 'a'; inputType: 'insertText'; isComposing: true; dataTransfer: dataTransfer;
		detail: 1; bubbles: true.
	event := InputEvent type: 'beforeinput' options: options.
	self assert: [ event class = InputEvent ].
	self assert: [ event type = 'beforeinput' ].
	self assert: [ event data = 'a' ].
	self assert: [ event inputType = 'insertText' ].
	self assert: [ event isComposing ].
	self assert: [ event dataTransfer = dataTransfer ].
	self assert: [ event dataTransfer class = DataTransfer ].
	self assert: [ ( event dataTransfer getData: 'text/plain' ) = 'Pasted' ].
	"Inherited options"
	self assert: [ event detail = 1 ].
	self assert: [ event bubbles ].
!
testListener
	| input options received |
	input := Document new createElement: 'input'.
	input addEventListener: 'input' then: [ :event | received := event ].
	options := InputEventOptions new data: 'x'.
	input dispatchEvent: ( InputEvent type: 'input' options: options ).
	self assert: [ received class = InputEvent ].
	self assert: [ received data = 'x' ].
!
