CLASS TestMessageChannel EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| channel |
	channel := MessageChannel new.
	self assert: [ channel class = MessageChannel ].
	self assert: [ channel port1 class = MessagePort ].
	self assert: [ channel port2 class = MessagePort ].
	self assert: [ channel port1 ~= channel port2 ].
	"Getters return the same JS port each time."
	self assert: [ channel port1 = channel port1 ].
	channel port1 close.
	channel port2 close.
!
testMessage
	| channel |
	channel := MessageChannel new.
	channel port2 onMessage: [ :event |
		self assert: [ ( String fromJs: event data js ) = 'Hello, channel!' ].
		channel port1 close.
		channel port2 close ].
	channel port1 postMessage: 'Hello, channel!'.
!
