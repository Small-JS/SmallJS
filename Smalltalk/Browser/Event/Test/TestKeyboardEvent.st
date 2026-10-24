CLASS TestKeyboardEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := KeyboardEvent type: 'keydown'.
	self assert: [ event class = KeyboardEvent ].
	self assert: [ event type = 'keydown' ].
	self assert: [ event key = '' ].
	self assert: [ event code = '' ].
	self assert: [ event location = 0 ].
	self assert: [ event repeat not ].
	self assert: [ event isComposing not ].
	self assert: [ event altKey not ].
	self assert: [ event ctrlKey not ].
	self assert: [ event metaKey not ].
	self assert: [ event shiftKey not ].
	self assert: [ ( event modifierState: 'Shift' ) not ].
!
testOptions
	| event options |
	options := KeyboardEventOptions new
		key: 'A'; code: 'KeyA'; location: 0; repeat: true; isComposing: false;
		shiftKey: true; ctrlKey: true;
		detail: 1; bubbles: true.
	event := KeyboardEvent type: 'keyup' options: options.
	self assert: [ event class = KeyboardEvent ].
	self assert: [ event type = 'keyup' ].
	self assert: [ event key = 'A' ].
	self assert: [ event code = 'KeyA' ].
	self assert: [ event location = 0 ].
	self assert: [ event repeat ].
	self assert: [ event isComposing not ].
	self assert: [ event shiftKey ].
	self assert: [ event ctrlKey ].
	self assert: [ event altKey not ].
	self assert: [ event metaKey not ].
	self assert: [ event modifierState: 'Shift' ].
	self assert: [ event modifierState: 'Control' ].
	"Inherited options"
	self assert: [ event detail = 1 ].
	self assert: [ event bubbles ].

	"Location of the key."
	options := KeyboardEventOptions new key: '1'; code: 'Numpad1'; location: 3.
	event := KeyboardEvent type: 'keydown' options: options.
	self assert: [ event location = 3 ].
!
testListener
	| input options keyboardEvent received |
	input := Document new createElement: 'input'.
	input addEventListener: 'keydown' then: [ :event | received := event ].
	options := KeyboardEventOptions new key: 'Enter'; code: 'Enter'.
	keyboardEvent := KeyboardEvent type: 'keydown' options: options.
	input dispatchEvent: keyboardEvent.
	self assert: [ received class = KeyboardEvent ].
	self assert: [ received key = 'Enter' ].
!
