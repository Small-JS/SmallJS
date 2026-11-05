CLASS TestWebSocketEcho EXTENDS TestWebSocket MODULE TestWebSocket CLASSVARS '' VARS 'server'

"Tests sending and receiving with the Core class WebSocket, using a local echo WebSocketServer.
 Only Node.js can run a server, so browsers only run the tests in the superclass TestWebSocket.
 The tests run one after another from a single test method, sharing one server."

METHODS

"Echo server"

async startServer
	"Start an echo server on a free port of localhost. Answer its URL.
	 It selects the first sub-protocol offered, if any."
	server := await WebSocketServer listen: ( WebSocketServerOptions new host: '127.0.0.1'; port: 0 ).
	server onConnection: [ :socket :request |
		socket onMessage: [ :event | socket send: event data ] ].
	^ 'ws://127.0.0.1:', server port toString.
!
async newOpenWebSocket: url
	| webSocket |
	webSocket := WebSocket url: url.
	await self waitForOpen: webSocket.
	^ webSocket.
!
async close: webSocket
	"Close webSocket and wait until it is closed."
	| closing |
	closing := self waitForClose: webSocket.
	webSocket close.
	await closing.
!

"Tests"

async test
	| url checking |
	url := await self startServer.
	"Stop the server also when a check fails, so Node.js can exit after the tests."
	checking := Promise fromJs: ( self checks: url ).
	await ( checking finally: [ server terminate ] ) js.
!
async checks: url
	await self checkOpenClose: url.
	await self checkProtocols: url.
	await self checkText: url.
	await self checkBinary: url.
!

"Async checks, run in sequence by: test"

async checkOpenClose: url
	| webSocket closing closeEvent |
	webSocket := await self newOpenWebSocket: url.
	self assert: [ webSocket isOpen ].
	self assert: [ webSocket readyState = 1 ].
	self assert: [ webSocket url = ( url, '/' ) ].
	self assert: [ webSocket protocol = '' ].

	closing := self waitForClose: webSocket.
	webSocket close: 3000 reason: 'Done'.
	self assert: [ webSocket isClosing ].
	closeEvent := await closing.
	self assert: [ webSocket isClosed ].
	self assert: [ closeEvent code = 3000 ].
	self assert: [ closeEvent wasClean ].
!
async checkProtocols: url
	| webSocket |
	webSocket := WebSocket url: url protocols: #( 'chat' 'json' ).
	await self waitForOpen: webSocket.
	self assert: [ webSocket protocol = 'chat' ].
	await self close: webSocket.

	webSocket := WebSocket url: url protocols: 'json'.
	await self waitForOpen: webSocket.
	self assert: [ webSocket protocol = 'json' ].
	await self close: webSocket.
!
async checkText: url
	| webSocket receiving event |
	webSocket := await self newOpenWebSocket: url.
	receiving := self receive: webSocket.
	webSocket send: 'Hello, WebSocket!'.
	event := await receiving.
	self assert: [ event class = MessageEvent ].
	self assert: [ ( String fromJs: event data js ) = 'Hello, WebSocket!' ].
	await self close: webSocket.
!
async checkBinary: url
	| webSocket receiving event |
	webSocket := await self newOpenWebSocket: url.
	webSocket binaryType: 'arraybuffer'.
	self assert: [ webSocket binaryType = 'arraybuffer' ].
	receiving := self receive: webSocket.
	webSocket send: ( Uint8Array from: #( 1 2 250 ) ).
	event := await receiving.
	self assert: [ event data jsClassName = 'ArrayBuffer' ].
	self assert: [ ( Uint8Array buffer: ( ArrayBuffer fromJs: event data js ) ) toHex = '0102fa' ].

	"The default binary type is: 'blob'."
	webSocket binaryType: 'blob'.
	receiving := self receive: webSocket.
	webSocket send: ( Blob fromArray: #( 'Blob' ) ).
	event := await receiving.
	self assert: [ event data jsClassName = 'Blob' ].
	self assert: [ ( Blob fromJs: event data js ) size = 4 ].
	await self close: webSocket.
!
