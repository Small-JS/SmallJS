CLASS TestMouseEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := MouseEventOptions new.
	self assert: [ options class = MouseEventOptions ].
	self assert: [ options altKey isNil ].
	self assert: [ options button isNil ].
	self assert: [ options client isNil ].
	self assert: [ options screen isNil ].
	self assert: [ options movement isNil ].

	"If only one coordinate is set, the other has the JS default value 0."
	INLINE 'options.js.clientY = 2; options.js.movementX = 5'.
	self assert: [ options client = ( 0 @ 2 ) ].
	self assert: [ options movement = ( 5 @ 0 ) ].
	INLINE 'delete options.js.clientY; delete options.js.movementX'.
	self assert: [ options client isNil ].
	self assert: [ options movement isNil ].
	self assert: [ options relatedTarget isNil ].

	options altKey: true; ctrlKey: true; metaKey: true; shiftKey: true.
	self assert: [ options altKey ].
	self assert: [ options ctrlKey ].
	self assert: [ options metaKey ].
	self assert: [ options shiftKey ].

	options button: 1; buttons: 4.
	self assert: [ options button = 1 ].
	self assert: [ options buttons = 4 ].

	options client: 1.5 @ 2; screen: 3 @ 4; movement: 5 @ 6.
	self assert: [ options client = ( 1.5 @ 2 ) ].
	self assert: [ options screen = ( 3 @ 4 ) ].
	self assert: [ options movement = ( 5 @ 6 ) ].

	options relatedTarget: Window default.
	self assert: [ options relatedTarget = Window default ].

	"Inherited options"
	options detail: 2; cancelable: true.
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
