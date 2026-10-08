CLASS Worker EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new: url
	^ self fromJs: INLINE 'new Worker( url.js )'.
!
new: url options: options
	^ self fromJs: INLINE 'new Worker( url.js, options.js )'.
!

METHODS

postMessage: object
	INLINE 'this.js.postMessage( object.$toJs() )'.
!
postMessage: object transfer: transferables
	"Transferables is an Array of transferable objects, like MessagePort,
	 whose ownership is transferred to the worker."
	INLINE 'this.js.postMessage( object.$toJs(), transferables.$toJs() )'.
!
terminate
	INLINE 'this.js.terminate()'.
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
onError: block
	"Called when an error occurs in the worker script, including failing to load it.
	 Block argument is an ErrorEvent, or an Event if the browser does not provide details."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJsSubEvent: jsEvent ) ].
	INLINE 'this.js.onerror = jsBlock.js'.
!
