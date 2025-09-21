CLASS MyNodeWorker EXTENDS Object MODULE TestNode CLASSVARS '' VARS ''

METHODS

start
	NodeMessagePort parentPort on: 'message' class: String then: [ :message | self onMessage: message ].

	self assert: [ NodeMessagePort isMainThread not ].

	NodeMessagePort setEnvironmentData: 'MyWorker' to: 'Saved'.
	self assert: [ ( NodeMessagePort getEnvironmentData: 'MyWorker' ) = 'Saved' ].
!
onMessage: message
	self assert: [ message = 'Hello, worker!' ].

	NodeMessagePort parentPort postMessage: 'Hello, main thread!'.
!
