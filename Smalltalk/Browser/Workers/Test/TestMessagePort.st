CLASS TestMessagePort EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Most MessagePort tests are async: the asserts run in the message handlers."

METHODS

newChannelPorts
	"Return an Array with the 2 entangled ports of a new MessageChannel."
	| channel |
	channel := MessageChannel new.
	^ Array with: channel port1 with: channel port2.
!
testClass
	| ports |
	ports := self newChannelPorts.
	self assert: [ ports first class = MessagePort ].
	self assert: [ ports first ~= ports last ].
	ports first close.
	ports last close.
!
testOnMessage
	| ports |
	ports := self newChannelPorts.
	ports last onMessage: [ :event |
		self assert: [ event class = MessageEvent ].
		self assert: [ ( String fromJs: event data js ) = 'Hello, port!' ].
		self assert: [ event ports length = 0 ].
		ports first close.
		ports last close ].
	ports last onMessageError: [ :event |
		self error: 'TestMessagePort: message error' ].
	ports first postMessage: 'Hello, port!'.
!
testAddEventListener
	| ports |
	ports := self newChannelPorts.
	ports last addEventListener: 'message' then: [ :event |
		self assert: [ event type = 'message' ].
		ports first close.
		ports last close ].
	"Required when using addEventListener instead of onmessage."
	ports last start.
	ports first postMessage: 'Hello, listener!'.
!
testTransfer
	| ports transferPorts |
	ports := self newChannelPorts.
	transferPorts := self newChannelPorts.
	ports last onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'Transfer' ].
		self assert: [ event ports length = 1 ].
		self assert: [ event ports first class = MessagePort ].
		event ports first close.
		transferPorts last close.
		ports first close.
		ports last close ].
	ports first postMessage: 'Transfer' transfer: ( Array with: transferPorts first ).
!
testClose
	| ports |
	ports := self newChannelPorts.
	ports last onMessage: [ :event |
		self error: 'TestMessagePort: message received on closed port' ].
	ports first close.
	ports first postMessage: 'Not delivered'.
	ports last close.
!
