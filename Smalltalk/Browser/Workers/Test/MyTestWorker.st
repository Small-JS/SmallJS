CLASS MyTestWorker EXTENDS Object MODULE TestBrowser CLASSVARS '' VARS ''

"Runs inside the worker thread started by TestWorker.
 Started from the worker script: Browser/src/worker.ts"

METHODS

start
	DedicatedWorkerGlobalScope default
		onMessage: [ :event | self onMessage: event ].
!
onMessage: event
	| message port |
	message := String fromJs: event data js.

	message = 'Hello, worker!' ifTrue: [
		DedicatedWorkerGlobalScope default postMessage: 'Hello, main thread!' ].

	"Reply on the port transferred with the message."
	message = 'Port' ifTrue: [
		port := ( event portsAs: MessagePort ) first.
		port postMessage: 'Hello, port!'.
		port close ].

	"Uncaught errors in the worker trigger the error event on the Worker in the main thread."
	message = 'Throw' ifTrue: [
		self error: 'MyTestWorker error' ].
!
