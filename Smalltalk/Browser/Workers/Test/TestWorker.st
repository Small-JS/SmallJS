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
testLoadError
	| worker |
	worker := Worker new: 'Script/doesNotExist.js' options: ( WorkerOptions new type: 'module' ).
	worker onError: [ :event |
		self assert: [ event type = 'error' ].
		worker terminate ].
!
