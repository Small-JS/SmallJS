CLASS TestNumber EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ 5 squared = 25 ].
	self assert: [ 25 isSquare ].
	self assert: [ 26 isSquare not ].
	self assert: [ 4 sqrt = 2.0 ].
	self assert: [ 3 negated = -3 ].
	self assert: [ -3 abs = 3 ].
	self assert: [ 8 \\ 3 = 2 ].

	self assertError: [ 1 / 0 ].
!
