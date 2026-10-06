CLASS TestSharedWorker EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Tests are async: the asserts run in the event handlers.
 The shared worker runs MyTestSharedWorker, started from the worker script: Browser/src/sharedWorker.ts
 Shared workers with the same url and name share one worker instance,
 so each test uses its own name to get its own instance."

METHODS

newSharedWorker: name
	^ SharedWorker new: 'Script/sharedWorker.js' options: ( WorkerOptions new name: name; type: 'module'; yourself ).
!
testClose
	"After a shared worker closes, a new SharedWorker with the same url and name
	 starts a new worker instance, so the counter starts over."
	| worker1 worker2 message |
	worker1 := self newSharedWorker: 'testClose'.
	worker1 port onMessage: [ :event1 |
		message := String fromJs: event1 data js.
		message = '1' ifTrue: [ worker1 port postMessage: 'Close' ].
		message = 'Closing' ifTrue: [
			worker1 port close.
			worker2 := self newSharedWorker: 'testClose'.
			worker2 port onMessage: [ :event2 |
				self assert: [ ( String fromJs: event2 data js ) = '1' ].
				worker2 port close ].
			worker2 port postMessage: 'Increment' ] ].
	worker1 port postMessage: 'Increment'.
!
testMessage
	| worker |
	worker := self newSharedWorker: 'testMessage'.
	self assert: [ worker class = SharedWorker ].
	self assert: [ worker port class = MessagePort ].
	worker port onMessage: [ :event |
		self assert: [ event class = MessageEvent ].
		self assert: [ ( String fromJs: event data js ) = 'Hello, main thread!' ].
		worker port close ].
	worker port onMessageError: [ :event |
		self error: 'TestSharedWorker: message error' ].
	worker port postMessage: 'Hello, shared worker!'.
!
testName
	| worker |
	worker := self newSharedWorker: 'testName'.
	worker port onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'testName' ].
		worker port close ].
	worker port postMessage: 'Name'.
!
testShared
	"Two SharedWorkers with the same url and name connect to the same worker instance,
	 so they share its counter."
	| worker1 worker2 |
	worker1 := self newSharedWorker: 'testShared'.
	worker2 := self newSharedWorker: 'testShared'.
	worker1 port onMessage: [ :event1 |
		self assert: [ ( String fromJs: event1 data js ) = '1' ].
		worker1 port close.
		worker2 port onMessage: [ :event2 |
			self assert: [ ( String fromJs: event2 data js ) = '2' ].
			worker2 port close ].
		worker2 port postMessage: 'Increment' ].
	worker1 port postMessage: 'Increment'.
!
testAddEventListener
	| worker |
	worker := self newSharedWorker: 'testAddEventListener'.
	worker port addEventListener: 'message' then: [ :event |
		self assert: [ event type = 'message' ].
		worker port close ].
	"With addEventListener the port must be started explicitly."
	worker port start.
	worker port postMessage: 'Hello, shared worker!'.
!
testLoadError
	| worker |
	worker := SharedWorker new: 'Script/doesNotExist.js' options: ( WorkerOptions new type: 'module' ).
	worker onError: [ :event |
		self assert: [ event type = 'error' ].
		worker port close ].
!
