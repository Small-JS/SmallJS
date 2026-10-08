CLASS SharedWorkerGlobalScope EXTENDS WorkerGlobalScope MODULE Browser CLASSVARS '' VARS ''

"Implements JS SharedWorkerGlobalScope: the global scope inside a SharedWorker thread."

METHODS

name
	"The name given to the SharedWorker constructor, or an empty string."
	^ String fromJs: INLINE 'this.js.name'.
!
close
	"Discard any queued tasks and close the shared worker."
	INLINE 'this.js.close()'.
!
onConnect: block
	"Called when a new SharedWorker connects to this worker.
	 Block argument is a MessageEvent, whose first port is used to communicate with the new SharedWorker."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MessageEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onconnect = jsBlock.js'.
!
