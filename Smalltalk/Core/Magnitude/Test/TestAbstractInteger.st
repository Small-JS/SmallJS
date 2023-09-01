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
