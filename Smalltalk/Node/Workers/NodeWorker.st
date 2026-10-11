CLASS NodeWorker EXTENDS EventEmitter MODULE Node1 CLASSVARS '' VARS ''

INLINE 'const workerThreads$ = await import( "worker_threads" );'

CLASSMETHODS

new: fileName
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileName.js )'.
!
new: fileName workerData: data
	"Data is cloned and available in the worker as: NodeMessagePort workerData."
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileName.js, { workerData: data.$toJs() } )'.
!

METHODS

"Events"

postMessage: value
	INLINE 'this.js.postMessage( value.js )'.
!

"Properties"

threadId
	^ Integer fromJs: INLINE 'this.js.threadId'.
!

"Process"

ref
	INLINE 'this.js.ref()'.
!
unref
	INLINE 'this.js.unref()'.
!
terminate
	INLINE 'this.js.terminate()'.
!

"TODO: These less common Worker features are not yet implemented:
	new Worker() options: argv, env (incl. workerThreads.SHARE_ENV), eval, execArgv,
		name, resourceLimits, stdin, stdout, stderr, trackUnmanagedFds, transferList
	worker.resourceLimits, workerThreads.resourceLimits
	worker.getHeapSnapshot(), worker.performance, worker.stdin/stdout/stderr
"
