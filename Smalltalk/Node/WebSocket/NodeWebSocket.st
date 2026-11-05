CLASS NodeWebSocket EXTENDS WebSocket MODULE WebSocket CLASSVARS '' VARS ''

"Implements the WebSocket class of the npm package 'ws'.
 Extends the standard JS WebSocket with Node-specific methods, like ping and terminate.
 Instances are the connections of a WebSocketServer, see: WebSocketServer>>onConnection:.
 They can also be created as client, like a standard WebSocket.

 Received text data is a String, binary data is a Node.js Buffer by default.
 Next to the standard binary types 'arraybuffer' and 'blob',
 binaryType: also accepts 'nodebuffer' (default) and 'fragments' (an Array of Buffers)."

INLINE 'import * as ws$ from "ws";'

CLASSMETHODS

"Creating"

url: url
	^ self fromJs: INLINE 'new ws$.WebSocket( url.$toJs() )'.
!
url: url protocols: protocols
	^ self fromJs: INLINE 'new ws$.WebSocket( url.$toJs(), protocols.$toJs() )'.
!

METHODS

"Closing"

terminate
	"Close the connection immediately, without the closing handshake."
	INLINE 'this.js.terminate()'.
!

"Ping and pong"

ping
	"The other side automatically answers with a pong, see: onPong:."
	INLINE 'this.js.ping()'.
!
ping: data
	"Data is a String or Buffer of at most 125 bytes. The pong contains the same data."
	INLINE 'this.js.ping( data.js )'.
!
pong
	"Pongs are sent automatically in reply to pings, so this is only needed as heartbeat."
	INLINE 'this.js.pong()'.
!
pong: data
	INLINE 'this.js.pong( data.js )'.
!
onPing: block
	"Block gets the ping data as Buffer."
	| jsBlock |
	jsBlock := [ :jsData | block value: ( Buffer fromJs: jsData ) ].
	INLINE 'this.js.on( "ping", jsBlock.js )'.
!
onPong: block
	"Block gets the pong data as Buffer."
	| jsBlock |
	jsBlock := [ :jsData | block value: ( Buffer fromJs: jsData ) ].
	INLINE 'this.js.on( "pong", jsBlock.js )'.
!

"Flow control"

pause
	"Stop receiving messages, until: resume."
	INLINE 'this.js.pause()'.
!
resume
	INLINE 'this.js.resume()'.
!
isPaused
	^ Boolean fromJs: INLINE 'this.js.isPaused'.
!
