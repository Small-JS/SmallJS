CLASS TestMessageEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| event |
	event := MessageEvent new: 'message'.
	self assert: [ event class = MessageEvent ].
	self assert: [ event data isNil ].
	self assert: [ event origin = '' ].
	self assert: [ event lastEventId = '' ].
	self assert: [ event ports length = 0 ].
	self assert: [ event source isNil ].
!
testOptions
	| event options |
	options := JsObject fromJs: INLINE '{ data: "Hello", origin: "https://example.com", lastEventId: "42" }'.
	event := MessageEvent new: 'message' options: options.
	self assert: [ event class = MessageEvent ].
	self assert: [ ( String fromJs: event data js ) = 'Hello' ].
	self assert: [ event origin = 'https://example.com' ].
	self assert: [ event lastEventId = '42' ].
	self assert: [ event ports length = 0 ].
	self assert: [ event source isNil ].
!
testPortsAndSource
	| channel port1 port2 event options |
	channel := MessageChannel new.
	port1 := channel port1.
	port2 := channel port2.
	options := JsObject fromJs: INLINE '{ ports: [ port1.js ], source: port2.js }'.
	event := MessageEvent new: 'message' options: options.
	self assert: [ event ports length = 1 ].
	self assert: [ event ports first class = MessagePort ].
	self assert: [ event ports first = port1 ].
	self assert: [ event source class = MessagePort ].
	self assert: [ event source = port2 ].
	port1 close.
	port2 close.
!
