CLASS TestNumber EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ 5 squared = 25 ].
	self assert: [ 25 isSquare ].
	self assert: [ 26 isSquare not ].
	self assert: [ 0 isSquare ].
	self assert: [ 1 isSquare ].
	self assert: [ -4 isSquare not ].
	self assert: [ 4 sqrt = 2.0 ].
	self assert: [ 3 negated = -3 ].
	self assert: [ -3 abs = 3 ].
	self assert: [ 8 \\ 3 = 2 ].
	self assert: [ -8 \\ 3 = -2 ].

	self assert: [ 7 isNan not ].
	self assert: [ 7 isFinite ].
	self assert: [ 7.5 isNan not ].
	self assert: [ 7.5 isFinite ].
	self assert: [ 7 toBigInt isNan not ].
	self assert: [ 7 toBigInt isFinite ].
	self assert: [ ( 1 / 2 ) isNan not ].
	self assert: [ ( 1 / 2 ) isFinite ].
	self assert: [ ( Float fromJs: INLINE 'NaN' ) isNan ].
	self assert: [ ( Float fromJs: INLINE 'NaN' ) isFinite not ].
	self assert: [ ( Float fromJs: INLINE 'Infinity' ) isNan not ].
	self assert: [ ( Float fromJs: INLINE 'Infinity' ) isFinite not ].

	self assertError: [ 1 / 0 ].
!
