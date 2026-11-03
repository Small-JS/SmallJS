CLASS TestTouchEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

disabled
	^ TouchEvent available not.
!
test
	| options touchOptions touch |
	options := TouchEventOptions new.
	self assert: [ options class = TouchEventOptions ].
	self assert: [ options touches isNil ].
	self assert: [ options altKey isNil ].

	touchOptions := TouchOptions new identifier: 1; target: Window default.
	touch := Touch options: touchOptions.
	options touches: ( Array with: touch ); targetTouches: ( Array with: touch ); changedTouches: Array new.
	self assert: [ options touches = ( Array with: touch ) ].
	self assert: [ options touches first class = Touch ].
	self assert: [ options targetTouches = ( Array with: touch ) ].
	self assert: [ options changedTouches isEmpty ].

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
