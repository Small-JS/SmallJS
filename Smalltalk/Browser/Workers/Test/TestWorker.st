CLASS TestWorker EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Tests are async: the asserts run in the event handlers.
 The worker runs MyTestWorker, started from the worker script: Browser/src/worker.ts"

METHODS

newWorker
	^ Worker new: 'Script/worker.js' options: ( WorkerOptions new type: 'module' ).
!
testMessage
	| worker |
	worker := self newWorker.
	self assert: [ worker class = Worker ].
	worker onMessage: [ :event |
		self assert: [ event class = MessageEvent ].
		self assert: [ ( String fromJs: event data js ) = 'Hello, main thread!' ].
		worker terminate ].
	worker onMessageError: [ :event |
		self error: 'TestWorker: message error' ].
	worker postMessage: 'Hello, worker!'.
!
testAddEventListener
	| worker |
	worker := self newWorker.
	worker addEventListener: 'message' then: [ :event |
		self assert: [ event type = 'message' ].
		worker terminate ].
	worker postMessage: 'Hello, worker!'.
!
testTransfer
	| worker channel |
	worker := self newWorker.
	channel := MessageChannel new.
	channel port1 onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'Hello, port!' ].
		channel port1 close.
		worker terminate ].
	worker postMessage: 'Port' transfer: ( Array with: channel port2 ).
!
testName
	| worker |
	worker := Worker new: 'Script/worker.js' options: ( WorkerOptions new type: 'module'; name: 'myWorker' ).
	worker onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'myWorker' ].
		worker terminate ].
	worker postMessage: 'Name'.
!
testTransferFromWorker
	| worker port |
	worker := self newWorker.
	worker onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'Port' ].
		self assert: [ event ports length = 1 ].
		port := event ports first.
		port onMessage: [ :portEvent |
			self assert: [ ( String fromJs: portEvent data js ) = 'Hello from worker port!' ].
			port close.
			worker terminate ] ].
	worker postMessage: 'Transfer'.
!
async testClose
	| worker messages |
	worker := self newWorker.
	messages := Array new.
	worker onMessage: [ :event | messages add: ( String fromJs: event data js ) ].
	worker postMessage: 'Close'.
	await Timer timeout: 200.
	worker postMessage: 'Hello, worker!'.
	await Timer timeout: 200.
	self assert: [ messages = #( 'Closing' ) ].
	worker terminate.
!
xtestError
	"This test is disabled by default because the forces error interferes with debugging.
	The test does work, in batch mode."
	| worker |
	worker := self newWorker.
	worker onError: [ :event |
		self assert: [ event class = ErrorEvent ].
		self assert: [ event message includes: 'MyTestWorker error' ].
		"Prevent the error from being reported as uncaught in the main thread."
		event preventDefault.
		worker terminate ].
	worker postMessage: 'Throw'.
!
