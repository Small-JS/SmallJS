CLASS TestWebSocket EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"These tests need no WebSocket server, so they run in browsers and in Node.js.
 Sending and receiving is tested in Node.js with a local echo server in subclass: TestWebSocketEcho.
 The helper methods are also used by that subclass."

METHODS

"Helpers"

invalidUrl
	"The reserved top-level domain 'invalid' never resolves, so connecting fails."
	^ 'wss://host.invalid'.
!
async waitForOpen: webSocket
	"Wait until webSocket is open. Fails if the connection fails."
	| opening |
	opening := Promise new: [ :resolve :reject |
		webSocket addEventListener: 'open' then: [ :event | resolve value: nil ].
		webSocket addEventListener: 'error' then: [ :event |
			reject value: 'TestWebSocket: Cannot connect to: ', webSocket url ] ].
	await opening js.
!
async receive: webSocket
	"Answer the next MessageEvent received by webSocket."
	| receiving messageEvent |
	receiving := Promise new: [ :resolve :reject |
		webSocket onMessage: [ :event |
			messageEvent := event.
			resolve value: nil ] ].
	await receiving js.
	^ messageEvent.
!
async waitForClose: webSocket
	"Answer the CloseEvent when webSocket is closed."
	| closing closeEvent |
	closing := Promise new: [ :resolve :reject |
		webSocket onClose: [ :event |
			closeEvent := event.
			resolve value: nil ] ].
	await closing js.
	^ closeEvent.
!

"Tests"

testCreation
	self assertError: [ WebSocket new ].
	"An invalid url, e.g. with an unsupported scheme, throws a JS DOMException, not an Error."
	self assert: [ ( [ WebSocket url: 'ftp://example.com' ] tryCatch: [ :error | error name ] ) = 'SyntaxError' ].
!
async testConnecting
	| webSocket |
	webSocket := WebSocket url: ( Url url: self invalidUrl ).
	self assert: [ webSocket class = WebSocket ].
	self assert: [ webSocket jsClassName = 'WebSocket' ].
	self assert: [ webSocket isConnecting ].
	self assert: [ webSocket readyState = 0 ].
	self assert: [ webSocket url = 'wss://host.invalid/' ].
	self assert: [ webSocket binaryType = 'blob' ].
	self assert: [ webSocket bufferedAmount = 0 ].
	self assert: [ webSocket protocol = '' ].
	self assert: [ webSocket extensions = '' ].
	await self waitForClose: webSocket.
	self assert: [ webSocket isClosed ].
!
async testError
	| webSocket erring closeEvent |
	webSocket := WebSocket url: self invalidUrl protocols: #( 'chat' ).
	erring := Promise new: [ :resolve :reject |
		webSocket onError: [ :event |
			self assert: [ event type = 'error' ].
			resolve value: nil ] ].
	closeEvent := await self waitForClose: webSocket.
	await erring js.
	self assert: [ closeEvent class = CloseEvent ].
	self assert: [ closeEvent code = 1006 ].
	self assert: [ closeEvent wasClean not ].
!
