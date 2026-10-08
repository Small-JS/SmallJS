CLASS TestCloseEvent EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| event |
	event := CloseEvent type: 'close'.
	self assert: [ event class = CloseEvent ].
	self assert: [ event type = 'close' ].
	self assert: [ event code = 0 ].
	self assert: [ event reason = '' ].
	self assert: [ event wasClean not ].
!
testOptions
	| options event |
	options := CloseEventOptions new
		code: 1000; reason: 'Done'; wasClean: true; yourself.
	event := CloseEvent type: 'close' options: options.
	self assert: [ event class = CloseEvent ].
	self assert: [ event code = 1000 ].
	self assert: [ event reason = 'Done' ].
	self assert: [ event wasClean ].
!
testFromJsSubEvent
	| event |
	event := Event fromJsSubEvent: INLINE 'new CloseEvent( "close", { code: 1001, reason: "Going away" } )'.
	self assert: [ event class = CloseEvent ].
	self assert: [ event code = 1001 ].
	self assert: [ event reason = 'Going away' ].
	self assert: [ event wasClean not ].
!
