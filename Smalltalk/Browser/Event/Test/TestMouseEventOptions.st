CLASS TestMouseEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := MouseEventOptions new.
	self assert: [ options class = MouseEventOptions ].
	self assert: [ options altKey isNil ].
	self assert: [ options button isNil ].
	self assert: [ options clientX isNil ].
	self assert: [ options relatedTarget isNil ].

	options altKey: true; ctrlKey: true; metaKey: true; shiftKey: true.
	self assert: [ options altKey ].
	self assert: [ options ctrlKey ].
	self assert: [ options metaKey ].
	self assert: [ options shiftKey ].

	options button: 1; buttons: 4.
	self assert: [ options button = 1 ].
	self assert: [ options buttons = 4 ].

	options clientX: 1.5; clientY: 2; screenX: 3; screenY: 4; movementX: 5; movementY: 6.
	self assert: [ options clientX = 1.5 ].
	self assert: [ options clientY = 2 ].
	self assert: [ options screenX = 3 ].
	self assert: [ options screenY = 4 ].
	self assert: [ options movementX = 5 ].
	self assert: [ options movementY = 6 ].

	options relatedTarget: Window default.
	self assert: [ options relatedTarget = Window default ].

	"Inherited options"
	options detail: 2; cancelable: true.
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
