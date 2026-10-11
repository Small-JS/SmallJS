CLASS NodeWorker EXTENDS EventEmitter MODULE Node1 CLASSVARS '' VARS ''

"Implements Node.js worker_threads Worker."

"Note: These Worker features are not yet implemented,
 because they need ST classes for Node.js streams:
	worker.stdin, worker.stdout, worker.stderr
	worker.getHeapSnapshot()
 These very new profiling functions are also not yet implemented:
	worker.startCpuProfile(), worker.startHeapProfile()"

INLINE 'const workerThreads$ = await import( "worker_threads" );'

CLASSMETHODS

new: fileName
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileName.js )'.
!
new: fileName workerData: data
	"Data is cloned and available in the worker as: NodeMessagePort workerData."
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileName.js, { workerData: data.$toJs() } )'.
!
new: fileName name: name
	"Name is available in the worker as: NodeMessagePort threadName."
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileName.js, { name: name.js } )'.
!
new: fileNameOrCode options: options
	"Options is a NodeWorkerOptions.
	 If option eval is true, the first argument is JS code instead of a file name."
	^ self fromJs: INLINE 'new workerThreads$.Worker( fileNameOrCode.js, options.js )'.
!

METHODS

"Messages"

postMessage: value
	INLINE 'this.js.postMessage( value.js )'.
!
postMessage: value transfer: transferables
	"Transferables is an Array of objects, like MessagePort and ArrayBuffer,
	 whose ownership is transferred to the worker, instead of cloned."
	INLINE 'this.js.postMessage( value.$toJs(), transferables.$toJs() )'.
!

"Properties"

threadId
	^ Integer fromJs: INLINE 'this.js.threadId'.
!
threadName
	^ String fromJs: INLINE 'this.js.threadName'.
!
resourceLimits
	"The actual resource limits of the worker JS engine.
	 Empty after the worker has stopped."
	^ NodeResourceLimits fromJs: INLINE 'this.js.resourceLimits'.
!

"Statistics"

async cpuUsage
	"Return a JsObject with keys user and system: the CPU time in microseconds."
	^ JsObject fromJs: INLINE 'await this.js.cpuUsage()'.
!
async getHeapStatistics
	"Return a JsObject with the V8 heap statistics of the worker,
	 with keys like: total_heap_size, used_heap_size, heap_size_limit."
	^ JsObject fromJs: INLINE 'await this.js.getHeapStatistics()'.
!
eventLoopUtilization
	"Return a JsObject with keys: idle, active (milliseconds) and utilization (0 to 1)."
	^ JsObject fromJs: INLINE 'this.js.performance.eventLoopUtilization()'.
!

"Process"

ref
	INLINE 'this.js.ref()'.
!
unref
	INLINE 'this.js.unref()'.
!
async terminate
	"Stop the worker. Return the exit code."
	^ Integer fromJs: INLINE 'await this.js.terminate()'.
!

