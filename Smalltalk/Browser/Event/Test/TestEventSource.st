CLASS TestEventSource EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"These tests need no server: the event stream is a 'data:' URL with MIME type 'text/event-stream'."

METHODS

"Helpers"

streamUrl
	"An event stream with an unnamed event and a named event 'greeting' with an id."
	^ 'data:text/event-stream,', ( Uri encodeComponent: 'data: Hello\n\nevent: greeting\ndata: Hi\nid: 7\n\n' ).
!
async receive: eventSource type: type
	"Answer the next MessageEvent of type received by eventSource. Fails on error."
	| receiving messageEvent |
	receiving := Promise new: [ :resolve :reject |
		eventSource addEventListener: type then: [ :event |
			messageEvent := event.
			resolve value: nil ].
		eventSource addEventListener: 'error' then: [ :event |
			reject value: 'TestEventSource: Error receiving from: ', eventSource url ] ].
	await receiving js.
	^ messageEvent.
!

"Tests"

testCreation
	| eventSource |
	self assertError: [ EventSource new ].
	"An invalid url throws a JS DOMException, not an Error."
	self assert: [ ( [ EventSource url: 'http://[' ] tryCatch: [ :error | error name ] ) = 'SyntaxError' ].
	eventSource := EventSource url: ( Url url: self streamUrl ).
	self assert: [ eventSource class = EventSource ].
	self assert: [ eventSource jsClassName = 'EventSource' ].
	self assert: [ eventSource isConnecting ].
	self assert: [ eventSource readyState = 0 ].
	self assert: [ eventSource url = self streamUrl ].
	self assert: [ eventSource withCredentials not ].
	eventSource close.
	self assert: [ eventSource isClosed ].
	eventSource := EventSource url: self streamUrl withCredentials: true.
	self assert: [ eventSource withCredentials ].
	eventSource close.
!
async testOpen
	| eventSource opening |
	eventSource := EventSource url: self streamUrl.
	opening := Promise new: [ :resolve :reject |
		eventSource onOpen: [ :event |
			self assert: [ event type = 'open' ].
			resolve value: nil ] ].
	await opening js.
	self assert: [ eventSource isOpen ].
	eventSource close.
!
async testMessage
	| eventSource receiving event |
	eventSource := EventSource url: self streamUrl.
	receiving := Promise new: [ :resolve :reject |
		eventSource onMessage: [ :messageEvent |
			event := messageEvent.
			resolve value: nil ] ].
	await receiving js.
	eventSource close.
	self assert: [ event class = MessageEvent ].
	self assert: [ event type = 'message' ].
	self assert: [ ( String fromJs: event data js ) = 'Hello' ].
	self assert: [ event lastEventId = '' ].
!
async testNamedEvent
	| eventSource event |
	eventSource := EventSource url: self streamUrl.
	event := await self receive: eventSource type: 'greeting'.
	eventSource close.
	self assert: [ event class = MessageEvent ].
	self assert: [ event type = 'greeting' ].
	self assert: [ ( String fromJs: event data js ) = 'Hi' ].
	self assert: [ event lastEventId = '7' ].
!
async testError
	"At the end of the stream the connection is lost, so the browser reconnects."
	| eventSource erring |
	eventSource := EventSource url: self streamUrl.
	erring := Promise new: [ :resolve :reject |
		eventSource onError: [ :event |
			self assert: [ event type = 'error' ].
			resolve value: nil ] ].
	await erring js.
	self assert: [ eventSource isConnecting ].
	eventSource close.
	self assert: [ eventSource isClosed ].
!
