CLASS MyTestSharedWorker EXTENDS Object MODULE TestBrowser CLASSVARS '' VARS 'counter'

"Runs inside the shared worker thread started by TestSharedWorker.
 Started from the worker script: Browser/src/sharedWorker.ts"

METHODS

start
	counter := 0.
	SharedWorkerGlobalScope default onConnect: [ :event | self onConnect: event ].
!
onConnect: event
	| port |
	port := ( event portsAs: MessagePort ) first.
	port onMessage: [ :messageEvent | self onMessage: messageEvent port: port ].
!
onMessage: event port: port
	| message |
	message := String fromJs: event data js.

	message = 'Hello, shared worker!' ifTrue: [
		port postMessage: 'Hello, main thread!' ].

	message = 'Name' ifTrue: [
		port postMessage: SharedWorkerGlobalScope default name ].

	"The counter is shared by all connections to this worker instance."
	message = 'Increment' ifTrue: [
		counter := counter + 1.
		port postMessage: counter toString ].

	"Reply before closing, so the main thread knows the worker is closing.
	 Messages already posted on the port are still delivered."
	message = 'Close' ifTrue: [
		port postMessage: 'Closing'.
		SharedWorkerGlobalScope default close ].
!
