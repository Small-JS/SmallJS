CLASS TestTimer EXTENDS Test MODULE TestCore CLASSVARS '' VARS 'count'

testTimeout
	| timer |
	timer := Timer timeout: 10 then: [ self onTimeout: timer ].
!
onTimeout: timer
	self assert: [ timer id > 0 ].
!
async testAwaitTimeout
	| timer |
	timer := Timer new.
	await timer timeout: 10.
	self assert: [ timer id > 0 ].

	await Timer timeout: 10.
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
	self assert: [ timer id > 0 ].
	self assert: [ count < 2 ].
	count increment >= 2 ifTrue: [
		timer clearInterval ].
!
