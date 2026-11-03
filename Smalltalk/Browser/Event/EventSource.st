CLASS EventSource EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: EventSource, a connection to a server sending events
 in the format 'text/event-stream' (Server-Sent Events).
 The connection is opened when the instance is created.
 When the connection is lost, the browser reconnects automatically, until close is called.
 Events with a name in the stream ('event:' field) are not received with onMessage:,
 receive them with: addEventListener: name then: [ :messageEvent | ... ]."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new EventSource with: EventSource url:[withCredentials:]'.
!
url: url
	"Url is a String or Url. A relative URL is resolved against the page URL.
	 Throws a JS DOMException named 'SyntaxError' if url is invalid."
	^ self fromJs: INLINE 'new EventSource( url.$toJs() )'.
!
url: url withCredentials: withCredentials
	"If withCredentials is true, a cross-origin request includes credentials, like cookies."
	^ self fromJs: INLINE 'new EventSource( url.$toJs(), { withCredentials: withCredentials.js } )'.
!

METHODS

"Properties"

readyState
	"0: connecting, 1: open, 2: closed. See also the testing methods."
	^ Integer fromJs: INLINE 'this.js.readyState'.
!
url
	"The absolute URL String of the source."
	^ String fromJs: INLINE 'this.js.url'.
!
withCredentials
	^ Boolean fromJs: INLINE 'this.js.withCredentials'.
!

"Testing"

isConnecting
	"Also true while reconnecting after the connection was lost."
	^ self readyState = 0.
!
isOpen
	^ self readyState = 1.
!
isClosed
	^ self readyState = 2.
!

"Closing"

close
	"Closes the connection and stops reconnecting."
	INLINE 'this.js.close()'.
!

"Events"

onOpen: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJs: jsEvent ) ].
	INLINE 'this.js.onopen = jsBlock.js'.
!
onMessage: block
	"Called for events without a name in the stream. The event data is a String."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MessageEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onmessage = jsBlock.js'.
!
onError: block
	"Called when the connection fails or is lost.
	 Afterwards, isConnecting means reconnecting and isClosed means the browser gave up."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJs: jsEvent ) ].
	INLINE 'this.js.onerror = jsBlock.js'.
!
