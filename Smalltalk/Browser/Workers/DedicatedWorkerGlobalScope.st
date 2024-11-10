CLASS DedicatedWorkerGlobalScope EXTENDS WorkerGlobalScope MODULE Browser CLASSVARS '' VARS ''

onMessage: block
	INLINE 'this.js.onmessage = ( messageEvent ) => block.$value$( stMessageEvent$class.$fromJs$( messageEvent ) )'.
!
postMessage: object
	INLINE 'this.js.postMessage( object.$toJs() )'.
!
