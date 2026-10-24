CLASS TestKeyboardEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := KeyboardEventOptions new.
	self assert: [ options class = KeyboardEventOptions ].
	self assert: [ options key isNil ].
	self assert: [ options code isNil ].
	self assert: [ options location isNil ].
	self assert: [ options repeat isNil ].
	self assert: [ options altKey isNil ].

	options key: 'Escape'; code: 'Escape'; location: 1; repeat: true; isComposing: true.
	self assert: [ options key = 'Escape' ].
	self assert: [ options code = 'Escape' ].
	self assert: [ options location = 1 ].
	self assert: [ options repeat ].
	self assert: [ options isComposing ].

	options altKey: true; ctrlKey: true; metaKey: true; shiftKey: true.
	self assert: [ options altKey ].
	self assert: [ options ctrlKey ].
	self assert: [ options metaKey ].
	self assert: [ options shiftKey ].

	"Inherited options"
	options detail: 2; cancelable: true.
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
