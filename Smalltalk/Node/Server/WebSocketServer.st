CLASS WebSocketServer EXTENDS EventEmitter MODULE Server CLASSVARS '' VARS ''

"Implements the WebSocketServer class of the npm package 'ws', an EventEmitter.
 Each client connection is a NodeWebSocket, see: onConnection:.
 Browsers and Node.js connect to it with the Core class WebSocket.

 Not implemented: the 'noServer' mode with handleUpgrade:, and the 'headers' event."

"The import ws$ of the npm package 'ws' is in class NodeWebSocket, in the same module."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new WebSocketServer with: WebSocketServer port: or options:[then:]'.
!
options: options
	"Options is a WebSocketServerOptions.
	 When using its port:, wait for onListening: before using the port."
	^ self fromJs: INLINE 'new ws$.WebSocketServer( options.js )'.
!
options: options then: block
	"Block is called without arguments when the server is listening, if options has a port:."
	^ self fromJs: INLINE 'new ws$.WebSocketServer( options.js, block.js )'.
!
port: port
	^ self options: ( WebSocketServerOptions new port: port ).
!
server: server
	"Share an existing HTTP Server, e.g. from: Express>>listen:then:."
	^ self options: ( WebSocketServerOptions new server: server ).
!
async listen: options
	"Answer a new server when it is listening. Options must have a port:."
	| listening webSocketServer |
	listening := Promise new: [ :resolve :reject |
		webSocketServer := self options: options then: [ resolve value: nil ].
		webSocketServer onError: [ :error | reject value: error js ] ].
	await listening js.
	^ webSocketServer.
!

METHODS

"Properties"

port
	"The port the server listens on. Useful when created with port 0."
	^ Integer fromJs: INLINE 'this.js.address().port'.
!
address
	"The IP address the server listens on, e.g. '127.0.0.1'."
	^ String fromJs: INLINE 'this.js.address().address'.
!
path
	"The URL path connections are accepted on, or nil for any path."
	^ String fromJs: INLINE 'this.js.options.path'.
!
clients
	"The connected clients as Array of NodeWebSocket. Empty if clientTracking: is false."
	^ Array fromJs: INLINE 'Array.from( this.js.clients ?? [] )' elementClass: NodeWebSocket.
!

"Events"

onConnection: block
	"Block gets 2 arguments: the NodeWebSocket of the new connection
	 and the IncomingMessage of its HTTP upgrade request, e.g. to inspect the URL or headers."
	| jsBlock |
	jsBlock := [ :jsSocket :jsRequest |
		block value: ( NodeWebSocket fromJs: jsSocket ) value: ( IncomingMessage fromJs: jsRequest ) ].
	INLINE 'this.js.on( "connection", jsBlock.js )'.
!
onListening: block
	"Block gets no arguments."
	INLINE 'this.js.on( "listening", block.js )'.
!
onError: block
	"Block gets an Error, e.g. when the port is already in use."
	| jsBlock |
	jsBlock := [ :jsError | block value: ( Error fromJs: jsError ) ].
	INLINE 'this.js.on( "error", jsBlock.js )'.
!
onClose: block
	"Block gets no arguments."
	INLINE 'this.js.on( "close", block.js )'.
!

"Testing"

shouldHandle: request
	"Answer true if the IncomingMessage request matches the path option."
	^ Boolean fromJs: INLINE 'this.js.shouldHandle( request.js )'.
!

"Closing"

async close
	"Stop accepting new connections. Waits until all clients have closed their connections.
	 Use terminate to close the connections immediately."
	INLINE 'await new Promise( ( resolve, reject ) =>
		this.js.close( error => error ? reject( error ) : resolve() ) )'.
!
async terminate
	"Close all connections immediately and wait until they are closed, then close the server."
	INLINE 'await Promise.all( Array.from( this.js.clients ?? [], client =>
		new Promise( resolve => { client.once( "close", resolve ); client.terminate() } ) ) )'.
	await self close.
!
