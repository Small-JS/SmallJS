CLASS NodeMessagePort EXTENDS EventEmitter MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

parentPort
	^ self fromJs: INLINE 'workerThreads$.parentPort'.
!
isMainThread
	^ Boolean fromJs: INLINE 'workerThreads$.isMainThread'.
!
getEnvironmentData: key
	^ String fromJs: INLINE 'workerThreads$.getEnvironmentData( key.js )'.
!
setEnvironmentData: key to: value
	INLINE 'workerThreads$.setEnvironmentData( key.js, value.js )'.
!

METHODS

start
	INLINE 'this.js.start()'.
!
ref
	INLINE 'this.js.ref()'.
!
unref
	INLINE 'this.js.unref()'.
!
close
	INLINE 'this.js.close()'.
!

"TODO: These less common features are not yet implemented:
	worker.markAsUntransferable(object)
	worker.isMarkedAsUntransferable(object)
	worker.markAsUncloneable(object)
	worker.moveMessagePortToContext(port, contextifiedSandbox)
	worker.postMessageToThread(threadId, value[, transferList][, timeout])
	worker.receiveMessageOnPort(port)
	worker.resourceLimits
	worker.SHARE_ENV
	worker.workerData
"
