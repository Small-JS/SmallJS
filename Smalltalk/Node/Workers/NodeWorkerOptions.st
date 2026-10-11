CLASS NodeWorkerOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Options for: NodeWorker new: fileName options: options."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

name
	"Shown in debuggers and available in the worker as: NodeMessagePort threadName."
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
eval
	^ Boolean fromJs: INLINE 'this.js.eval'.
!
eval: isEval
	"If true, the first argument of NodeWorker new:options: is JS code, instead of a file name.
	 The code runs as a CommonJS script."
	INLINE 'this.js.eval = isEval.js'.
!
workerData
	^ Object fromJs: INLINE 'this.js.workerData'.
!
workerData: data
	"Data is cloned and available in the worker as: NodeMessagePort workerData."
	INLINE 'this.js.workerData = data.$toJs()'.
!
transferList
	^ Array fromJs: INLINE 'this.js.transferList'.
!
transferList: transferables
	"Objects in workerData to transfer, instead of clone, like MessagePorts and ArrayBuffers."
	INLINE 'this.js.transferList = transferables.$toJs()'.
!
argv
	^ Array fromJs: INLINE 'this.js.argv' elementClass: String.
!
argv: strings
	"Appended to process.argv in the worker."
	INLINE 'this.js.argv = strings.$toJs()'.
!
execArgv
	^ Array fromJs: INLINE 'this.js.execArgv' elementClass: String.
!
execArgv: strings
	"Node.js CLI options for the worker. Defaults to those of the parent thread."
	INLINE 'this.js.execArgv = strings.$toJs()'.
!
env
	^ JsObject fromJs: INLINE 'this.js.env'.
!
env: jsObject
	"Initial process.env of the worker. Defaults to a copy of the parent thread's."
	INLINE 'this.js.env = jsObject.js'.
!
shareEnv
	^ Boolean fromJs: INLINE 'this.js.env === workerThreads$.SHARE_ENV'.
!
shareEnv: share
	"If true, the worker and the parent thread share process.env."
	INLINE 'if( share.js ) this.js.env = workerThreads$.SHARE_ENV; else delete this.js.env'.
!
resourceLimits
	^ NodeResourceLimits fromJs: INLINE 'this.js.resourceLimits'.
!
resourceLimits: resourceLimits
	INLINE 'this.js.resourceLimits = resourceLimits.js'.
!
stdin
	^ Boolean fromJs: INLINE 'this.js.stdin'.
!
stdin: stdin
	"If true, worker stdin is a stream the parent can write to, instead of empty."
	INLINE 'this.js.stdin = stdin.js'.
!
stdout
	^ Boolean fromJs: INLINE 'this.js.stdout'.
!
stdout: stdout
	"If true, worker stdout is not piped to the parent's stdout."
	INLINE 'this.js.stdout = stdout.js'.
!
stderr
	^ Boolean fromJs: INLINE 'this.js.stderr'.
!
stderr: stderr
	"If true, worker stderr is not piped to the parent's stderr."
	INLINE 'this.js.stderr = stderr.js'.
!
trackUnmanagedFds
	^ Boolean fromJs: INLINE 'this.js.trackUnmanagedFds'.
!
trackUnmanagedFds: track
	"If true (default), file descriptors opened with fs open are closed when the worker exits."
	INLINE 'this.js.trackUnmanagedFds = track.js'.
!
