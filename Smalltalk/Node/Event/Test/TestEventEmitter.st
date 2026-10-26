CLASS TestEventEmitter EXTENDS Test MODULE TestNode CLASSVARS '' VARS 'calls lastArg'

test
	| eventEmitter listeners |
	eventEmitter := EventEmitter new.
	self assert: [ eventEmitter jsClassName = 'EventEmitter' ].

	"Max"

	eventEmitter maxListeners: 20.
	self assert: [ eventEmitter maxListeners = 20 ].

	"Add"

	calls := 0.
	self assert: [ ( eventEmitter emit: 'test' ) not ].
	eventEmitter on: 'test' then: [ self onTest ].
	self assert: [ eventEmitter emit: 'test' ].
	self assert: [ calls = 1 ].
	eventEmitter emit: 'test'.
	self assert: [ calls = 2 ].

	self assert: [ ( eventEmitter listenerCount: 'test' ) = 1 ].
	listeners := eventEmitter listeners: 'test'.
	self assert: [ listeners length = 1 ].
	self assert: [ listeners first class = Block ].

	calls := 0.
	eventEmitter on: 'testArg' class: Integer
		then: [ :arg | self onTestArg: arg ].
	self assert: [ eventEmitter emit: 'testArg' value: 23 ].
	self assert: [ calls = 1 ].
	self assert: [ lastArg = 23 ].

	self assert: [ ( eventEmitter listenerCount: 'testArg' ) = 1 ].
	self assert: [ eventEmitter eventNames = #( 'test' 'testArg') ].

	"Remove"

	eventEmitter removeAllListeners: 'test'.
	self assert: [ ( eventEmitter listenerCount: 'test' ) = 0 ].
	calls := 0.
	self assert: [ ( eventEmitter emit: 'test' ) not ].
	self assert: [ calls = 0 ].

	"Once"

	calls := 0.
	eventEmitter once: 'testOnce' then: [ self onTestOnce ].
	self assert: [ ( eventEmitter listenerCount: 'testOnce' ) = 1 ].
	self assert: [ eventEmitter emit: 'testOnce' ].
	self assert: [ calls = 1 ].
	self assert: [ ( eventEmitter listenerCount: 'testOnce' ) = 0 ].
	self assert: [ ( eventEmitter emit: 'testOnce' ) not ].
	self assert: [ calls = 1 ].

	calls := 0.
	eventEmitter once: 'testOnceArg' class: String
		then: [ :arg | self onTestOnceArg: arg ].
	self assert: [ ( eventEmitter listenerCount: 'testOnceArg' ) = 1 ].
	self assert: [ eventEmitter emit: 'testOnceArg' value: 'arg' ].
	self assert: [ calls = 1 ].
	self assert: [ lastArg = 'arg' ].
	self assert: [ ( eventEmitter listenerCount: 'testOnceArg' ) = 0 ].
!
onTest
	calls := calls + 1.
!
onTestArg: arg
	calls := calls + 1.
	lastArg := arg.
!
onTestOnce
	calls := calls + 1.
!
onTestOnceArg: arg
	calls := calls + 1.
	lastArg := arg.
!
