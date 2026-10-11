CLASS TestNodeMessagePort EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

testMainThread
	self assert: [ NodeMessagePort isMainThread ].
	self assert: [ NodeMessagePort parentPort isNil ].
	self assert: [ NodeMessagePort threadId = 0 ].
	self assert: [ NodeMessagePort threadName class = String ].
	self assert: [ NodeMessagePort workerData isNil ].
!
testRef
	| channel port |
	channel := MessageChannel new.
	port := NodeMessagePort fromJs: channel port1 js.
	self assert: [ port isKindOf: MessagePort ].
	port onMessage: [ :event | ].
	self assert: [ port hasRef ].
	port unref.
	self assert: [ port hasRef not ].
	port ref.
	self assert: [ port hasRef ].
	port close.
	channel port2 close.
!
testMessage
	| channel port1 port2 |
	channel := MessageChannel new.
	port1 := NodeMessagePort fromJs: channel port1 js.
	port2 := NodeMessagePort fromJs: channel port2 js.
	port2 onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'Hello, Node port!' ].
		port1 close.
		port2 close ].
	port1 postMessage: 'Hello, Node port!'.
!
testReceiveMessageOnPort
	| channel |
	channel := MessageChannel new.
	self assert: [ ( NodeMessagePort receiveMessageOnPort: channel port2 ) isNil ].
	channel port1 postMessage: 'Sync message'.
	self assert: [ ( NodeMessagePort receiveMessageOnPort: channel port2 ) = 'Sync message' ].
	self assert: [ ( NodeMessagePort receiveMessageOnPort: channel port2 ) isNil ].
	channel port1 close.
	channel port2 close.
!
