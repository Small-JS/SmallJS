CLASS DedicatedWorkerGlobalScope EXTENDS WorkerGlobalScope MODULE Browser CLASSVARS '' VARS ''

"Implements JS DedicatedWorkerGlobalScope: the global scope inside a Worker thread."

METHODS

name
	"The name given in the WorkerOptions of the Worker constructor, or an empty string."
	^ String fromJs: INLINE 'this.js.name'.
!
close
	"Discard any queued tasks and close the worker."
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
postMessage: object
	INLINE 'this.js.postMessage( object.$toJs() )'.
!
postMessage: object transfer: transferables
	"Transferables is an Array of transferable objects, like MessagePort,
	 whose ownership is transferred to the main thread."
	INLINE 'this.js.postMessage( object.$toJs(), transferables.$toJs() )'.
!
