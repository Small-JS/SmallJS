CLASS TestNodeWebSocket EXTENDS TestWebSocket MODULE TestServer CLASSVARS '' VARS 'server serverSocket'

"Tests NodeWebSocket as client and as server connection of a local WebSocketServer.
 Extends TestWebSocket for its helper methods.
 The checks run one after another from a single test method, sharing one server."

METHODS

"Helpers"

async newConnection
	"Answer a new open client NodeWebSocket. Variable serverSocket is set to its server side."
	| connecting webSocket |
	connecting := Promise new: [ :resolve :reject |
		server onConnection: [ :socket :request |
			serverSocket := socket.
			resolve value: nil ] ].
	webSocket := NodeWebSocket url: 'ws://127.0.0.1:', server port toString.
	await self waitForOpen: webSocket.
	await connecting js.
	server removeAllListeners: 'connection'.
	^ webSocket.
!

"Tests"

async test
	| checking |
	server := await WebSocketServer listen: ( WebSocketServerOptions new host: '127.0.0.1'; port: 0 ).
	"Stop the server also when a check fails, so Node.js can exit after the tests."
	checking := Promise fromJs: self checks.
	await ( checking finally: [ server terminate ] ) js.
!
async checks
	await self checkClient.
	await self checkPingPong.
	await self checkPause.
	await self checkTerminate.
!

"Async checks, run in sequence by: test"

async checkClient
	| webSocket receiving event |
	webSocket := await self newConnection.
	self assert: [ webSocket class = NodeWebSocket ].
	self assert: [ webSocket jsClassName = 'WebSocket' ].
	self assert: [ webSocket isOpen ].
	self assert: [ webSocket binaryType = 'nodebuffer' ].

	"Text is received as String, binary data as Buffer."
	receiving := self receive: webSocket.
	serverSocket send: 'Text'.
	event := await receiving.
	self assert: [ ( String fromJs: event data js ) = 'Text' ].

	receiving := self receive: webSocket.
	serverSocket send: ( Buffer from: 'Binary' ).
	event := await receiving.
	self assert: [ event data jsClassName = 'Buffer' ].
	self assert: [ ( Buffer fromJs: event data js ) decodeToString = 'Binary' ].
	webSocket close.
	await self waitForClose: webSocket.
!
async checkPingPong
	| webSocket pinging ponging pingData pongData |
	webSocket := await self newConnection.
	pinging := Promise new: [ :resolve :reject |
		serverSocket onPing: [ :data |
			pingData := data.
			resolve value: nil ] ].
	ponging := Promise new: [ :resolve :reject |
		webSocket onPong: [ :data |
			pongData := data.
			resolve value: nil ] ].
	webSocket ping: 'Hi'.
	await pinging js.
	await ponging js.
	self assert: [ pingData class = Buffer ].
	self assert: [ pingData decodeToString = 'Hi' ].
	self assert: [ pongData decodeToString = 'Hi' ].
	webSocket close.
	await self waitForClose: webSocket.
!
async checkPause
	| webSocket |
	webSocket := await self newConnection.
	self assert: [ webSocket isPaused not ].
	webSocket pause.
	self assert: [ webSocket isPaused ].
	webSocket resume.
	self assert: [ webSocket isPaused not ].
	webSocket close.
	await self waitForClose: webSocket.
!
async checkTerminate
	"Terminating closes the connection without closing handshake."
	| webSocket clientClosing serverClosing closeEvent |
	webSocket := await self newConnection.
	clientClosing := self waitForClose: webSocket.
	serverClosing := self waitForClose: serverSocket.
	webSocket terminate.
	await clientClosing.
	self assert: [ webSocket isClosed ].
	closeEvent := await serverClosing.
	self assert: [ closeEvent code = 1006 ].
	self assert: [ closeEvent wasClean not ].
!
