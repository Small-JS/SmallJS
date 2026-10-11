CLASS MyNodeWorker EXTENDS Object MODULE TestNode CLASSVARS '' VARS ''

METHODS

start
	NodeMessagePort parentPort onMessage: [ :event |
		self onMessage: ( String fromJs: event data js ) ].

	self assert: [ NodeMessagePort isMainThread not ].
	self assert: [ NodeMessagePort threadId > 0 ].
	self assert: [ NodeMessagePort threadName isEmpty not ].
	self assert: [ NodeMessagePort workerData = 'Worker data' ].

	NodeMessagePort setEnvironmentData: 'MyWorker' to: 'Saved'.
	self assert: [ ( NodeMessagePort getEnvironmentData: 'MyWorker' ) = 'Saved' ].
!
onMessage: message
	self assert: [ message = 'Hello, worker!' ].

	NodeMessagePort parentPort postMessage: 'Hello, main thread!'.
!
