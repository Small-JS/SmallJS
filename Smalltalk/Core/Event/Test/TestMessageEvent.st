CLASS TestMessageEvent EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| event |
	event := MessageEvent type: 'message'.
	self assert: [ event class = MessageEvent ].
	self assert: [ event type = 'message' ].
	self assert: [ event data isNil ].
	self assert: [ event origin = '' ].
	self assert: [ event lastEventId = '' ].
	self assert: [ event ports length = 0 ].
	self assert: [ event source isNil ].
!
testOptions
	| event options |
	options := JsObject fromJs: INLINE '{ data: "Hello", origin: "https://example.com", lastEventId: "42" }'.
	event := MessageEvent type: 'message' options: options.
	self assert: [ event class = MessageEvent ].
	self assert: [ ( String fromJs: event data js ) = 'Hello' ].
	self assert: [ event origin = 'https://example.com' ].
	self assert: [ event lastEventId = '42' ].
	self assert: [ event ports length = 0 ].
	self assert: [ event source isNil ].
!
testPortsAndSource
	| jsChannel options event jsPort jsSource |
	"MessageChannel is not in Core, but its JS class exists in both Browser and Node."
	jsChannel := INLINE 'new MessageChannel()'.
	options := JsObject fromJs: INLINE '{ ports: [ jsChannel.port1 ], source: jsChannel.port2 }'.
	event := MessageEvent type: 'message' options: options.
	self assert: [ event ports length = 1 ].
	self assert: [ event ports first class = EventTarget ].
	jsPort := event ports first js.
	self assert: [ Boolean fromJs: INLINE 'jsPort === jsChannel.port1' ].
	self assert: [ ( event portsAs: JsObject ) first class = JsObject ].
	self assert: [ event source class = EventTarget ].
	jsSource := event source js.
	self assert: [ Boolean fromJs: INLINE 'jsSource === jsChannel.port2' ].
	INLINE 'jsChannel.port1.close(); jsChannel.port2.close()'.
!
testFromJsSubEvent
	| event |
	event := Event fromJsSubEvent: INLINE 'new MessageEvent( "message", { data: "Hello" } )'.
	self assert: [ event class = MessageEvent ].
	self assert: [ ( String fromJs: event data js ) = 'Hello' ].
!
