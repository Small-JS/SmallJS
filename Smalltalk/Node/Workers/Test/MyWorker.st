CLASS MyWorker EXTENDS Object MODULE TestNode CLASSVARS '' VARS ''

METHODS

start
	MessagePort parentPort on: 'message' class: String then: [ :message | self onMessage: message ].

	self assert: [ MessagePort isMainThread not ].

	MessagePort setEnvironmentData: 'MyWorker' to: 'Saved'.
	self assert: [ ( MessagePort getEnvironmentData: 'MyWorker' ) = 'Saved' ].
!
onMessage: message
	self assert: [ message = 'Hello, worker!' ].

	MessagePort parentPort postMessage: 'Hello, main thread!'.
!
