CLASS TestTimer EXTENDS Test MODULE TestCore CLASSVARS '' VARS 'count'

testTimeout
	Timer timeout: 50 then: [ self onTimeout ].
!
onTimeout
	self assert: [ true ].
!
testClearTimeout
	| timer |
	timer := Timer timeout: 10 then: [ self notReached ].
	timer clearTimeout.
!
notReached
	self assert: [ false ].
!
testInterval
	| timer |
	count := 0.
	timer := Timer interval: 10 then: [ self onInterval: timer ].
!
onInterval: timer
	self assert: [ count < 2 ].
	count increment >= 2 ifTrue: [
		timer clearInterval ].
!
