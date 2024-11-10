CLASS MyWorker EXTENDS Object MODULE MyWorker CLASSVARS ''	VARS ''

start
	DedicatedWorkerGlobalScope default
		onMessage: [ :messageEvent | self onMessage: messageEvent ].
!
onMessage: messageEvent
	| myMessage |

	MessageEvent. 	"Force import"

	myMessage := MyMessage fromJs: messageEvent data.
	self log: 'MyWorker received message form main: id: ', myMessage toString.

	"Do the work."
	self work: myMessage size.

	"Report my worker id as being finished."
	self log: 'MyWorker: Posting message back to main with id: ', myMessage id toString.
	DedicatedWorkerGlobalScope default postMessage: myMessage id.
!
work: size
	"The work consists of adding random numbers 'size' times 10 K.
	 The result is discarded."

	| sum |
	sum := 0.

	size timesRepeat: [
		10000 timesRepeat: [
			sum := sum + Float random ] ].
!
