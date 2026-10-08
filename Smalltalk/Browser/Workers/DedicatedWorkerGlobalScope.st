CLASS DedicatedWorkerGlobalScope EXTENDS WorkerGlobalScope MODULE Browser CLASSVARS '' VARS ''

onMessage: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MessageEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onmessage = jsBlock.js'.
!
postMessage: object
	INLINE 'this.js.postMessage( object.$toJs() )'.
!
