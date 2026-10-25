CLASS TestEventTarget EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

testNew
	| target |
	target := EventTarget new.
	self assert: [ target class = EventTarget ].
	self assert: [ target jsClassName = 'EventTarget' ].
!
testEquality
	| target |
	target := EventTarget new.
	self assert: [ target = target ].
	self assert: [ target = ( EventTarget fromJs: target js ) ].
	self assert: [ target ~= EventTarget new ].
!
testAddEventListener
	| target received currentTarget count |
	target := EventTarget new.
	count := 0.
	target addEventListener: 'test' then: [ :event |
		received := event.
		currentTarget := event currentTarget.
		count := count + 1 ].
	self assert: [ target eventIds length = 1 ].

	"Listener is called synchronously on dispatch."
	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 1 ].
	self assert: [ received class = Event ].
	self assert: [ received type = 'test' ].
	self assert: [ received target = target ].
	"currentTarget is only set during dispatch."
	self assert: [ currentTarget = target ].
	self assert: [ received currentTarget isNil ].

	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 2 ].

	"Listener is not called for other event types."
	target dispatchEvent: ( Event type: 'other' ).
	self assert: [ count = 2 ].
!
testMultipleListeners
	| target count1 count2 |
	target := EventTarget new.
	count1 := 0.
	count2 := 0.
	target addEventListener: 'test' then: [ :event | count1 := count1 + 1 ].
	target addEventListener: 'test' then: [ :event | count2 := count2 + 1 ].
	target addEventListener: 'other' then: [ :event | count2 := count2 + 10 ].
	self assert: [ target eventIds length = 3 ].

	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count1 = 1 ].
	self assert: [ count2 = 1 ].

	target dispatchEvent: ( Event type: 'other' ).
	self assert: [ count1 = 1 ].
	self assert: [ count2 = 11 ].
!
testDuplicateListener
	| target count block |
	target := EventTarget new.
	count := 0.
	block := [ :event | count := count + 1 ].

	"As in JS, the same block for the same type is only added once."
	target addEventListener: 'test' then: block.
	target addEventListener: 'test' then: block.
	self assert: [ target eventIds length = 1 ].
	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 1 ].

	"The same block for another type is added."
	target addEventListener: 'other' then: block.
	self assert: [ target eventIds length = 2 ].

	target removeEventListener: 'test' then: block.
	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 1 ].
!
testRemoveEventListener
	| target count block1 block2 |
	target := EventTarget new.
	count := 0.
	block1 := [ :event | count := count + 1 ].
	block2 := [ :event | count := count + 10 ].
	target addEventListener: 'test' then: block1.
	target addEventListener: 'test' then: block2.
	target addEventListener: 'other' then: block1.

	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 11 ].

	"Only the listener with the same type and block is removed."
	target removeEventListener: 'test' then: block1.
	self assert: [ target eventIds length = 2 ].
	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 21 ].
	target dispatchEvent: ( Event type: 'other' ).
	self assert: [ count = 22 ].

	"Removing a listener that is not registered does nothing."
	target removeEventListener: 'test' then: block1.
	target removeEventListener: 'unknown' then: block2.
	self assert: [ target eventIds length = 2 ].

	"Removing a listener from a target that never had one does nothing."
	EventTarget new removeEventListener: 'test' then: block1.

	target removeEventListener: 'test' then: block2.
	target removeEventListener: 'other' then: block1.
	self assert: [ target eventIds length = 0 ].
	target dispatchEvent: ( Event type: 'test' ).
	target dispatchEvent: ( Event type: 'other' ).
	self assert: [ count = 22 ].
!
testDispatchEvent
	| target event |
	target := EventTarget new.

	"Without listeners, dispatch returns true."
	self assert: [ target dispatchEvent: ( Event type: 'test' ) ].

	"Return false only if a listener cancels a cancelable event."
	target addEventListener: 'test' then: [ :anEvent | anEvent preventDefault ].
	event := Event type: 'test' options: ( EventOptions new cancelable: true ).
	self assert: [ ( target dispatchEvent: event ) not ].
	self assert: [ event defaultPrevented ].

	event := Event type: 'test'.
	self assert: [ target dispatchEvent: event ].
	self assert: [ event defaultPrevented not ].
!
testStopImmediatePropagation
	| target count |
	target := EventTarget new.
	count := 0.
	target addEventListener: 'test' then: [ :event |
		count := count + 1.
		event stopImmediatePropagation ].
	target addEventListener: 'test' then: [ :event | count := count + 10 ].

	target dispatchEvent: ( Event type: 'test' ).
	self assert: [ count = 1 ].
!
