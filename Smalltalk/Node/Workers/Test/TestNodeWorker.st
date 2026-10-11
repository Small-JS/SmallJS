CLASS TestNodeWorker EXTENDS Test MODULE TestNode CLASSVARS '' VARS 'worker'

METHODS

test
	worker := NodeWorker new: './out/worker.js' workerData: 'Worker data'.
	self assert: [ worker threadId >= 0 ].

	worker on: 'message' class: String then: [ :message | self onMessage: message ].
	worker on: 'messageerror' class: Error then: [ :error | self onMessageError: error ].
	worker on: 'error' class: Error then: [ :error | self onError: error ].
	worker on: 'exit' class: Integer then: [ :code | self onExit: code ].

	worker postMessage: 'Hello, worker!'.
!
onMessage: message
	self assert: [ message = 'Hello, main thread!' ].
	self terminate.
!
onMessageError: error
	self error: 'TestNodeWorker: NodeWorker massage error: ', error message.
!
onError: error
	self error: 'TestNodeWorker: NodeWorker error: ', error message.
!
terminate
	worker ref.
	worker unref.
	worker terminate.
!
onExit: code
	self assert: [ code >= 0 ].
!
async testEval
	| code options limits worker arrayBuffer reply usage stats utilization exitCode |

	"Worker code that replies with the byte length of transferred ArrayBuffers."
	code := 'const { parentPort } = require( "worker_threads" ); ', 
		'parentPort.on( "message", ( arrayBuffer ) => parentPort.postMessage( arrayBuffer.byteLength ) );'.
	limits := NodeResourceLimits new.
	limits maxOldGenerationSizeMb: 64.
	options := NodeWorkerOptions new.
	options eval: true; name: 'EvalWorker'; resourceLimits: limits.
	worker := NodeWorker new: code options: options.
	self assert: [ worker threadId > 0 ].
	self assert: [ worker threadName = 'EvalWorker' ].

	arrayBuffer := ArrayBuffer new: 8.
	worker postMessage: arrayBuffer transfer: ( Array with: arrayBuffer ).
	"The ArrayBuffer is transferred, so no longer usable by the sender."
	self assert: [ arrayBuffer byteLength = 0 ].
	reply := await self nextMessage: worker.
	self assert: [ reply = 8 ].

	self assert: [ worker resourceLimits maxOldGenerationSizeMb = 64 ].
	self assert: [ worker resourceLimits stackSizeMb > 0 ].

	usage := await worker cpuUsage.
	self assert: [ ( usage atJsProperty: 'user' ) >= 0 ].
	self assert: [ ( usage atJsProperty: 'system' ) >= 0 ].
	stats := await worker getHeapStatistics.
	self assert: [ ( stats atJsProperty: 'used_heap_size' ) > 0 ].
	utilization := worker eventLoopUtilization atJsProperty: 'utilization'.
	self assert: [ ( utilization >= 0 ) & ( utilization <= 1 ) ].

	exitCode := await worker terminate.
	self assert: [ exitCode = 1 ].
!
async nextMessage: worker
	^ Object fromJs: INLINE 'await new Promise( ( resolve ) => worker.js.once( "message", resolve ) )'.
!
