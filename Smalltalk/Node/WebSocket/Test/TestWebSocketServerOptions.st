CLASS TestWebSocketServerOptions EXTENDS Test MODULE TestWebSocket CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := WebSocketServerOptions new.
	self assert: [ options class = WebSocketServerOptions ].
	self assert: [ options port = nil ].

	options port: 8080.
	self assert: [ options port = 8080 ].
	options host: '127.0.0.1'.
	self assert: [ options host = '127.0.0.1' ].
	options path: '/ws'.
	self assert: [ options path = '/ws' ].
	options maxPayload: 1024.
	self assert: [ options maxPayload = 1024 ].
	options clientTracking: false.
	self assert: [ options clientTracking not ].
	options perMessageDeflate: true.
	self assert: [ options perMessageDeflate ].
	self assert: [ options server = nil ].
!
