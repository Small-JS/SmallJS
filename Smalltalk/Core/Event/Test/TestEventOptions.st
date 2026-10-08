CLASS TestEventOptions EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := EventOptions new.
	self assert: [ options class = EventOptions ].
	self assert: [ options bubbles isNil ].
	self assert: [ options cancelable isNil ].
	self assert: [ options composed isNil ].

	options bubbles: true.
	self assert: [ options bubbles ].
	options cancelable: true.
	self assert: [ options cancelable ].
	options composed: true.
	self assert: [ options composed ].

	options := EventOptions new bubbles: false; cancelable: true; composed: false; yourself.
	self assert: [ options bubbles not ].
	self assert: [ options cancelable ].
	self assert: [ options composed not ].
!
testEvent
	| event |
	event := Event type: 'custom'.
	self assert: [ event class = Event ].
	self assert: [ event bubbles not ].
	self assert: [ event cancelable not ].
	self assert: [ event composed not ].

	event := Event type: 'custom' options: ( EventOptions new bubbles: true; cancelable: true; composed: true; yourself ).
	self assert: [ event class = Event ].
	self assert: [ event type = 'custom' ].
	self assert: [ event bubbles ].
	self assert: [ event cancelable ].
	self assert: [ event composed ].

	event := Event type: 'custom' options: ( EventOptions new cancelable: true; yourself ).
	self assert: [ event bubbles not ].
	self assert: [ event cancelable ].
	event preventDefault.
	self assert: [ event defaultPrevented ].
!
