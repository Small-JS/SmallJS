CLASS WebSocket EXTENDS EventTarget MODULE Core CLASSVARS '' VARS ''

"This class encapsulates the JS class: WebSocket, a client connection to a WebSocket server.
 It works in browsers and in Node.js.
 The connection is opened when the instance is created.
 Wait for onOpen: before sending data."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new WebSocket with: WebSocket url:[protocols:]'.
!
url: url
	"Url is a String or Url with scheme 'wss:' or 'ws:'.
	 In browsers, a relative URL is resolved against the page URL.
	 Throws a JS DOMException named 'SyntaxError' if url is invalid."
	^ self fromJs: INLINE 'new WebSocket( url.$toJs() )'.
!
url: url protocols: protocols
	"Protocols is a sub-protocol String or an Array of them.
	 The server selects one, see: protocol."
	^ self fromJs: INLINE 'new WebSocket( url.$toJs(), protocols.$toJs() )'.
!

METHODS

"Properties"

binaryType
	"The type of binary data received: 'blob' (default) or 'arraybuffer'."
	^ String fromJs: INLINE 'this.js.binaryType'.
!
binaryType: binaryType
	INLINE 'this.js.binaryType = binaryType.js'.
!
bufferedAmount
	"The number of bytes queued by send: but not yet transmitted."
	^ Integer fromJs: INLINE 'this.js.bufferedAmount'.
!
extensions
	"The extensions selected by the server, or an empty String."
	^ String fromJs: INLINE 'this.js.extensions'.
!
protocol
	"The sub-protocol selected by the server, or an empty String."
	^ String fromJs: INLINE 'this.js.protocol'.
!
readyState
	"0: connecting, 1: open, 2: closing, 3: closed. See also the testing methods."
	^ Integer fromJs: INLINE 'this.js.readyState'.
!
url
	"The absolute URL String of the connection."
	^ String fromJs: INLINE 'this.js.url'.
!

"Testing"

isConnecting
	^ self readyState = 0.
!
isOpen
	^ self readyState = 1.
!
isClosing
	^ self readyState = 2.
!
isClosed
	^ self readyState = 3.
!

"Sending"

send: data
	"Data can be a String, Blob, ArrayBuffer or TypedArray.
	 Throws an error if the connection is still connecting."
	INLINE 'this.js.send( data.js )'.
!

"Closing"

close
	INLINE 'this.js.close()'.
!
close: code
	"Code is 1000 (normal closure) or in the range 3000-4999."
	INLINE 'this.js.close( code.js )'.
!
close: code reason: reason
	"Reason is a String of at most 123 bytes UTF-8."
	INLINE 'this.js.close( code.js, reason.js )'.
!

"Events"

onOpen: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJs: jsEvent ) ].
	INLINE 'this.js.onopen = jsBlock.js'.
!
onMessage: block
	"The event data is a String, or for binary data a Blob or ArrayBuffer, see: binaryType:."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MessageEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onmessage = jsBlock.js'.
!
onError: block
	"Called when the connection fails or closes with an error. Followed by onClose:."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJs: jsEvent ) ].
	INLINE 'this.js.onerror = jsBlock.js'.
!
onClose: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( CloseEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onclose = jsBlock.js'.
!
