CLASS TestEvent EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| event |
	event := Event type: 'test'.
	self assert: [ event class = Event ].
	self assert: [ event type = 'test' ].
	self assert: [ event bubbles not ].
	self assert: [ event cancelable not ].
!
testTimeStamp
	| event1 event2 |
	event1 := Event type: 'test'.
	event2 := Event type: 'test'.
	self assert: [ event1 timeStamp class = Float ].
	self assert: [ event1 timeStamp > 0 ].
	self assert: [ event2 timeStamp >= event1 timeStamp ].
!
