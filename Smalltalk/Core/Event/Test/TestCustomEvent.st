CLASS TestCustomEvent EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| event |
	event := CustomEvent type: 'custom'.
	self assert: [ event class = CustomEvent ].
	self assert: [ event type = 'custom' ].
	self assert: [ event detail isNil ].
	self assert: [ event bubbles not ].
!
testOptions
	| options event |
	options := CustomEventOptions new
		detail: 'Hello'; bubbles: true; cancelable: true; yourself.
	event := CustomEvent type: 'custom' options: options.
	self assert: [ event class = CustomEvent ].
	self assert: [ ( String fromJs: event detail js ) = 'Hello' ].
	self assert: [ event bubbles ].
	self assert: [ event cancelable ].
!
testFromJsSubEvent
	| event |
	event := Event fromJsSubEvent: INLINE 'new CustomEvent( "custom", { detail: 42 } )'.
	self assert: [ event class = CustomEvent ].
	self assert: [ ( Integer fromJs: event detail js ) = 42 ].
!
testDispatch
	| target received |
	target := EventTarget fromJs: INLINE 'new EventTarget()'.
	target addEventListener: 'custom' then: [ :event | received := event ].
	target dispatchEvent: ( CustomEvent type: 'custom'
		options: ( CustomEventOptions new detail: 'Hello'; yourself ) ).
	self assert: [ received class = CustomEvent ].
	self assert: [ ( String fromJs: received detail js ) = 'Hello' ].
!
