CLASS TestEventEmitter EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| eventEmitter listeners |
	eventEmitter := EventEmitter new.
	self assert: [ eventEmitter jsClassName = 'EventEmitter' ].

	"Max"

	eventEmitter maxListeners: 20.
	self assert: [ eventEmitter maxListeners = 20 ].

	"Add"

	eventEmitter on: 'test' then: [ self onTest ].
	eventEmitter emit: 'test'.

	self assert: [ ( eventEmitter listenerCount: 'test' ) = 1 ].
	listeners := eventEmitter listeners: 'test'.
	self assert: [ listeners length = 1 ].
	self assert: [ listeners first class = Block ].

	eventEmitter on: 'testArg' class: Integer
		then: [ :arg | self onTestArg: arg ].
	eventEmitter emit: 'testArg' value: 23.

	self assert: [ ( eventEmitter listenerCount: 'testArg' ) = 1 ].
	self assert: [ eventEmitter eventNames = #( 'test' 'testArg') ].

	"Remove"

	eventEmitter removeAllListeners: 'test'.
	self assert: [ ( eventEmitter listenerCount: 'test' ) = 0 ].


	"Once"

	eventEmitter once: 'testOnce' then: [ self onTestOnce ].
	self assert: [ ( eventEmitter listenerCount: 'testOnce' ) = 1 ].
	eventEmitter emit: 'testOnce'.
	self assert: [ ( eventEmitter listenerCount: 'testOnce' ) = 0 ].

	eventEmitter once: 'testOnceArg' class: String
		then: [ :arg | self onTestOnceArg: arg ].
	self assert: [ ( eventEmitter listenerCount: 'testOnceArg' ) = 1 ].
	eventEmitter emit: 'testOnceArg' value: 'arg'.
	self assert: [ ( eventEmitter listenerCount: 'testOnceArg' ) = 0 ].


!
onTest
	self assert: [ true ].
!
onTestArg: arg
	self assert: [ arg = 23 ].
!
onTestOnce
	self assert: [ true ].
!
onTestOnceArg: arg
	self assert: [ arg = 'arg' ].
!
