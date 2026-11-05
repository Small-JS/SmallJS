CLASS TestWebSocketServer EXTENDS TestWebSocket MODULE TestWebSocket CLASSVARS '' VARS ''

"Tests WebSocketServer, with the Core class WebSocket as client.
 Extends TestWebSocket for its helper methods.
 The checks run one after another from a single test method, each with its own server on a free port."

METHODS

"Helpers"

async newServer
	^ await WebSocketServer listen: self newOptions.
!
newOptions
	^ WebSocketServerOptions new host: '127.0.0.1'; port: 0.
!
urlFor: server path: path
	^ 'ws://127.0.0.1:', server port toString, path.
!

"Tests"

testCreation
	self assertError: [ WebSocketServer new ].
!
async test
	await self checkListen.
	await self checkConnection.
	await self checkPath.
	await self checkSharedServer.
	await self checkError.
!

"Async checks, run in sequence by: test"

async checkListen
	| server closed |
	server := await self newServer.
	self assert: [ server class = WebSocketServer ].
	self assert: [ server jsClassName = 'WebSocketServer' ].
	self assert: [ server port > 0 ].
	self assert: [ server address = '127.0.0.1' ].
	self assert: [ server path = nil ].
	self assert: [ server clients isEmpty ].

	"WebSocketServer is an EventEmitter."
	server onConnection: [ :socket :request | ].
	self assert: [ ( server listenerCount: 'connection' ) = 1 ].

	closed := false.
	server onClose: [ closed := true ].
	await server close.
	self assert: [ closed ].
!
async checkConnection
	| server connecting serverSocket upgradeRequest webSocket closing closeEvent |
	server := await self newServer.
	connecting := Promise new: [ :resolve :reject |
		server onConnection: [ :socket :request |
			serverSocket := socket.
			upgradeRequest := request.
			resolve value: nil ] ].
	webSocket := WebSocket url: ( self urlFor: server path: '/chat?room=1' ) protocols: #( 'chat' ).
	await self waitForOpen: webSocket.
	await connecting js.

	self assert: [ serverSocket class = NodeWebSocket ].
	self assert: [ serverSocket isOpen ].
	self assert: [ serverSocket protocol = 'chat' ].
	self assert: [ upgradeRequest class = IncomingMessage ].
	self assert: [ upgradeRequest url = '/chat?room=1' ].
	self assert: [ ( upgradeRequest headers get: 'sec-websocket-protocol' ) = 'chat' ].
	self assert: [ server shouldHandle: upgradeRequest ].
	self assert: [ server clients length = 1 ].
	self assert: [ server clients first = serverSocket ].

	"The server closes the connection."
	closing := self waitForClose: webSocket.
	serverSocket close: 4000 reason: 'Bye'.
	closeEvent := await closing.
	self assert: [ closeEvent code = 4000 ].
	self assert: [ closeEvent reason = 'Bye' ].
	await server close.
!
async checkPath
	| server webSocket closeEvent |
	server := await WebSocketServer listen: ( self newOptions path: '/ws' ).
	self assert: [ server path = '/ws' ].

	"Connections on other paths are rejected."
	webSocket := WebSocket url: ( self urlFor: server path: '/other' ).
	closeEvent := await self waitForClose: webSocket.
	self assert: [ closeEvent code = 1006 ].

	webSocket := WebSocket url: ( self urlFor: server path: '/ws' ).
	await self waitForOpen: webSocket.
	self assert: [ webSocket isOpen ].
	await server terminate.
	self assert: [ server clients isEmpty ].
!
async checkSharedServer
	"Share the HTTP server of Express, so both use the same port."
	| express listening httpServer server webSocket |
	express := Express new.
	listening := Promise new: [ :resolve :reject |
		httpServer := express listen: 0 then: [ :error |
			error isNil ifTrue: [ resolve value: nil ] ifFalse: [ reject value: error js ] ] ].
	await listening js.

	server := WebSocketServer server: httpServer.
	webSocket := WebSocket url: 'ws://localhost:', server port toString.
	await self waitForOpen: webSocket.
	self assert: [ webSocket isOpen ].
	self assert: [ server clients length = 1 ].
	await server terminate.
	await httpServer terminate.
!
async checkError
	"Listening on a port that is in use fails."
	| server failing message |
	server := await self newServer.
	failing := Promise new: [ :resolve :reject |
		( WebSocketServer options: ( self newOptions port: server port ) )
			onError: [ :error |
				message := error message.
				resolve value: nil ] ].
	await failing js.
	self assert: [ message includes: 'EADDRINUSE' ].
	await server close.
!
