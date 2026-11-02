CLASS WebSocketServerOptions EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

"Options for: WebSocketServer options:[then:].
 Set either port: to create a new HTTP server, or server: to use an existing one."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

port
	^ Integer fromJs: INLINE 'this.js.port'.
!
port: port
	"Port 0 selects a free port, see: WebSocketServer>>port."
	INLINE 'this.js.port = port.js'.
!
host
	^ String fromJs: INLINE 'this.js.host'.
!
host: host
	"The host name or IP address to listen on, e.g. '127.0.0.1'. Default: all addresses."
	INLINE 'this.js.host = host.js'.
!
server
	^ Server fromJs: INLINE 'this.js.server'.
!
server: server
	"An existing HTTP Server to share, e.g. from: Express>>listen:then:."
	INLINE 'this.js.server = server.js'.
!
path
	^ String fromJs: INLINE 'this.js.path'.
!
path: path
	"Only accept connections on this URL path, e.g. '/ws'. Default: any path."
	INLINE 'this.js.path = path.js'.
!
maxPayload
	^ Integer fromJs: INLINE 'this.js.maxPayload'.
!
maxPayload: bytes
	"The maximum message size in bytes. Default: 100 MiB."
	INLINE 'this.js.maxPayload = bytes.js'.
!
clientTracking
	^ Boolean fromJs: INLINE 'this.js.clientTracking'.
!
clientTracking: isTracking
	"If true (default), the connected clients are available with: WebSocketServer>>clients."
	INLINE 'this.js.clientTracking = isTracking.js'.
!
perMessageDeflate
	^ Boolean fromJs: INLINE 'this.js.perMessageDeflate'.
!
perMessageDeflate: isCompressing
	"Enable message compression, if the client supports it. Default: false."
	INLINE 'this.js.perMessageDeflate = isCompressing.js'.
!
