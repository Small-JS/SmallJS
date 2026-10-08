CLASS MessagePort EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''

"Implements JS MessagePort: one of the two ports of a MessageChannel."

METHODS

postMessage: object
	INLINE 'this.js.postMessage( object.$toJs() )'.
!
postMessage: object transfer: transferables
	"Transferables is an Array of transferable objects, like MessagePort,
	 whose ownership is transferred to the receiver."
	INLINE 'this.js.postMessage( object.$toJs(), transferables.$toJs() )'.
!
start
	"Start sending messages queued on the port.
	 Only needed when using addEventListener; onMessage: starts the port implicitly."
	INLINE 'this.js.start()'.
!
close
	"Disconnect the port, so it is no longer active."
	INLINE 'this.js.close()'.
!
onMessage: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MessageEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onmessage = jsBlock.js'.
!
onMessageError: block
	"Called when a message is received that cannot be deserialized."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MessageEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onmessageerror = jsBlock.js'.
!
