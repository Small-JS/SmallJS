CLASS WebWorkersApp EXTENDS BrowserApp MODULE WebWorkersApp CLASSVARS ''
	VARS 'workers startTime
		workSizeInput workersInput startButton resultsTable'

start
	workers := #().
	self bindElements.
!
bindElements
	workSizeInput := Document getElementById: 'workSizeInput' class: HtmlInputElement.
	workersInput := Document getElementById: 'workersInput' class: HtmlInputElement.
	resultsTable := Document getElementById: 'resultsTable' class: HtmlTableElement.
	startButton := Document getElementById: 'startButton' class: HtmlButtonElement.
	startButton onClick: [ self onStart ].
!
totalWorkSize
	^ workSizeInput value toInteger.
!
workerCount
	^ workersInput value toInteger.
!
workerSize
	^ ( self totalWorkSize / self workerCount ) toInteger.
!
onStart
	self clearResults.
	self startWorkers.
!
clearResults
	"(Re)load worker results into table."
	| row |
	resultsTable tBody innerHtml: ''.
	1 to: self workerCount do: [ :index |
		row := resultsTable tBody insertRow: -1.
		row insertCell textContent: index toString.
		row insertCell ].
!
startWorkers
	self stopWorkers.
	startTime := Date now.
	1 to: self workerCount do: [ :index |
		self startWorker: index ].
!
stopWorkers
	workers do: [ :worker |
		worker terminate ].
	workers := #().
!
startWorker: index
	| options worker message |

	options := WorkerOptions new type: 'module'.
	worker := Worker new: 'Script/worker.js' options: options.
	worker onMessage: [ :event | self onWorkerMessage: event ].
	worker onError: [ :event | self onWorkerError: event index: index ].

	message := MyMessage new id: index; size: self workerSize.
	worker postMessage: message.

	workers add: worker.
!
onWorkerMessage: event
	| runTime workerId  cell |
	runTime := Date now - startTime.

	workerId := Integer fromJs: event data js.
	self log: 'WebWorkersApp.onWorkerMessage: received id: ', workerId toString.

	( workers at: workerId - 1 ) terminate.

	cell := ( resultsTable rows at: workerId ) cells at: 1.
	cell textContent: runTime toString.
!
onWorkerError: event index: index
	"Show the error of worker number index in its result cell and in the console.
	 The event is an ErrorEvent, or a plain Event if the browser gives no details,
	 like when the worker script fails to load."
	| message cell |

	message := ( event isKindOf: ErrorEvent )
		ifTrue: [ event message ]
		ifFalse: [ 'Worker script failed to load or run: Script/worker.js' ].
	self log: 'WebWorkersApp.onWorkerError: worker id: ', index toString, ': ', message.

	cell := ( resultsTable rows at: index ) cells at: 1.
	cell textContent: 'Error'.
!

"Accessing (used by tests)"

workSizeInput
	^ workSizeInput.
!
workersInput
	^ workersInput.
!
resultsTable
	^ resultsTable.
!
startButton
	^ startButton.
!
