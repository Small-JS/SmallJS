CLASS TestAbstractInteger EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ 42 toInteger = 42 ].
!
testIteration
	| sum |

	sum := 0.
	1 to: 4 do: [ :num | sum := sum + num ].
	self assert: [ sum = 10 ].

	sum := 0.
	4 to: 1 by: -1 do: [ :num | sum := sum + num ].
	self assert: [ sum = 10 ].

	sum := 0.
	3 timesRepeat: [ sum increment ].
	self assert: [ sum = 3 ].
!
async testIterationAwait
	| sum |

	sum := 0.
	await 1 to: 4 doAwait: async [ :num |
		await Timer timeout: 1.
		sum := sum + num ].
	self assert: [ sum = 10 ].

	sum := 0.
	await 4 to: 1 by: -1 doAwait: async [ :num |
		await Timer timeout: 1.
		sum := await sum + num ].
	self assert: [ sum = 10 ].

	sum := 0.
	await 3 timesRepeatAwait: async [
		await Timer timeout: 1.
		sum := sum + 1 ].
	self assert: [ sum = 3 ].
!
testFunctions
	self assert: [ 8 even ].
	self assert: [ 7 odd ].
	self assert: [ 4 factorial = 24 ].
	self assert: [ 23 isPrime ].
	self assert: [ 21 isPrime not ].
	self assert: [ 21 factors last = 7 ].
	self assert: [ 21 firstDivider = 3 ].

!
