CLASS TestNodeWorker EXTENDS Test MODULE TestNode CLASSVARS '' VARS 'worker'

METHODS

test
	worker := NodeWorker new: './out/worker.js'.

	self assert: [ worker threadId >= 0 ].

	worker on: 'message' class: String then: [ :message | self onMessage: message ].
	worker on: 'messageerror' class: Error then: [ :error | self onMessageError: error ].
	worker on: 'error' class: Error then: [ :error | self onError: error ].
	worker on: 'exit' class: Integer then: [ :code | self onExit: code ].

	worker postMessage: 'Hello, worker!'.
!
onMessage: message
	self assert: [ message = 'Hello, main thread!' ].
	self terminate.
!
onMessageError: error
	self error: 'TestNodeWorker: NodeWorker massage error: ', error message.
!
onError: error
	self error: 'TestNodeWorker: NodeWorker error: ', error message.
!
terminate
	worker ref.
	worker unref.
	worker terminate.
!
onExit: code
	self assert: [ code >= 0 ].
!
