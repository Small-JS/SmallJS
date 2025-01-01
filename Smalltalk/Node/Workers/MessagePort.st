CLASS MessagePort EXTENDS EventEmitter MODULE Node1 CLASSVARS '' VARS ''

INLINE 'import { parentPort, isMainThread, setEnvironmentData, getEnvironmentData } from "worker_threads";'

CLASSMETHODS

parentPort
	^ self fromJs: INLINE 'parentPort'.
!
isMainThread
	^ Boolean fromJs: INLINE 'isMainThread'.
!
getEnvironmentData: key
	^ String fromJs: INLINE 'getEnvironmentData( key.js )'.
!
setEnvironmentData: key to: value
	INLINE 'setEnvironmentData( key.js, value.js )'.
!

"These less common features are not yet implemented:
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
