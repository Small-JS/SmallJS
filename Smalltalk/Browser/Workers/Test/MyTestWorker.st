CLASS MyTestWorker EXTENDS Object MODULE TestBrowser CLASSVARS '' VARS ''

"Runs inside the worker thread started by TestWorker.
 Started from the worker script: Browser/src/worker.ts"

METHODS

start
	DedicatedWorkerGlobalScope default
		onMessage: [ :event | self onMessage: event ];
		onMessageError: [ :event | DedicatedWorkerGlobalScope default postMessage: 'Message error' ].
!
onMessage: event
	| message port channel |
	message := String fromJs: event data js.

	message = 'Hello, worker!' ifTrue: [
		DedicatedWorkerGlobalScope default postMessage: 'Hello, main thread!' ].

	message = 'Name' ifTrue: [
		DedicatedWorkerGlobalScope default postMessage: DedicatedWorkerGlobalScope default name ].

	"Transfer a port to the main thread, and reply on it."
	message = 'Transfer' ifTrue: [
		channel := MessageChannel new.
		DedicatedWorkerGlobalScope default postMessage: 'Port' transfer: ( Array with: channel port2 ).
		channel port1 postMessage: 'Hello from worker port!'.
		channel port1 close ].

	"After close, the worker does not handle any more messages."
	message = 'Close' ifTrue: [
		DedicatedWorkerGlobalScope default postMessage: 'Closing'; close ].

	"Reply on the port transferred with the message."
	message = 'Port' ifTrue: [
		port := event ports first.
		port postMessage: 'Hello, port!'.
		port close ].

	"Uncaught errors in the worker trigger the error event on the Worker in the main thread."
	message = 'Throw' ifTrue: [
		self error: 'MyTestWorker error' ].
!
