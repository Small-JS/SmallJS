CLASS TestInputEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options dataTransfer |
	options := InputEventOptions new.
	self assert: [ options class = InputEventOptions ].
	self assert: [ options data isNil ].
	self assert: [ options dataTransfer isNil ].
	self assert: [ options inputType isNil ].
	self assert: [ options isComposing isNil ].

	dataTransfer := DataTransfer new.
	options data: 'a'; dataTransfer: dataTransfer; inputType: 'insertText'; isComposing: true.
	self assert: [ options data = 'a' ].
	self assert: [ options dataTransfer = dataTransfer ].
	self assert: [ options inputType = 'insertText' ].
	self assert: [ options isComposing ].

	"Inherited options"
	options detail: 2; cancelable: true.
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
