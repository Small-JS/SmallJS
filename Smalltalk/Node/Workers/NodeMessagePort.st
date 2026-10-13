CLASS NodeMessagePort EXTENDS MessagePort MODULE Node1 CLASSVARS '' VARS ''

"Implements Node.js worker_threads MessagePort.
 Extends the standard JS MessagePort with Node-specific methods."

"Note: These less common worker_threads module features are not yet implemented:
	workerThreads.markAsUntransferable(object)
	workerThreads.isMarkedAsUntransferable(object)
	workerThreads.markAsUncloneable(object)
	workerThreads.moveMessagePortToContext(port, contextifiedSandbox)
	workerThreads.postMessageToThread(threadId, value[, transferList][, timeout])
	workerThreads.isInternalThread
	workerThreads.locks (needs a LockManager class in Core)
	workerThreads.BroadcastChannel (same as the global; belongs in Core)
"

CLASSMETHODS

parentPort
	^ self fromJs: INLINE 'workerThreads$.parentPort'.
!
isMainThread
	^ Boolean fromJs: INLINE 'workerThreads$.isMainThread'.
!
threadId
	"The id of the current thread: 0 in the main thread."
	^ Integer fromJs: INLINE 'workerThreads$.threadId'.
!
threadName
	"The name of the current thread. Workers default to: 'WorkerThread'."
	^ String fromJs: INLINE 'workerThreads$.threadName'.
!
workerData
	"Data passed to NodeWorker new:workerData:, converted to ST. Nil in the main thread."
	^ Object fromJs: INLINE 'workerThreads$.workerData'.
!
receiveMessageOnPort: port
	"Synchronously receive a single message from port, converted to ST.
	 Returns nil if no message is available."
	^ Object fromJs: INLINE 'workerThreads$.receiveMessageOnPort( port.js )?.message'.
!
getEnvironmentData: key
	^ String fromJs: INLINE 'workerThreads$.getEnvironmentData( key.js )'.
!
setEnvironmentData: key to: value
	INLINE 'workerThreads$.setEnvironmentData( key.js, value.js )'.
!

METHODS

ref
	"Keep the event loop alive while this port is active (default)."
	INLINE 'this.js.ref()'.
!
unref
	"Allow the thread to exit if this is the only active handle."
	INLINE 'this.js.unref()'.
!
hasRef
	^ Boolean fromJs: INLINE 'this.js.hasRef()'.
!

