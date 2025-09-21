CLASS NodeWorker EXTENDS EventEmitter MODULE Node1 CLASSVARS '' VARS ''

INLINE 'const workerThreads$ = await import( "worker_threads" );'

CLASSMETHODS

new: fileName
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileName.js )'.
!

METHODS

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
