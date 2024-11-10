CLASS WebWorkersApp EXTENDS BrowserApp MODULE WebWorkersApp CLASSVARS ''
	VARS 'workers workSizeInput workersInput startButton resultsTable
		startTime'

start
	workers := #().
	self bindElements.

	self testMode ifTrue: [
		^ TestWebWorkersApp new test: self ].
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
	"(Re)oad worker results into table."
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
	| worker message |

	worker := Worker new: 'Script/worker.js'
		options: ( WorkerOptions new type: 'module' ).
	worker onMessage: [ :event | self onWorkerMessage: event ].

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
