CLASS TestBlock EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| milliseconds num |
	self assert: [ [ 1 + 2 ] value = 3 ].
	self assert: [ ( [ :a | a squared ] value: 3 ) = 9 ].
	self assert: [ ( [ :a :b | a * b ] value: 3 value: 4 ) = 12 ].
	self assert: [ [ true ] and: [ true ] ].
	self assert: [ [ false ] or: [ true ] ].
	self assert: [ ( [ :x | x + 1 ] script ) includes: 'x.$$plus' ].

	milliseconds := Date new.
	[ Date new <= milliseconds ] whileTrue.
	self assert: [ Date new > milliseconds ].

	num := 0.
	[ num < 3 ]	whileTrue: [ num := num + 1 ].
	self assert: [ num = 3 ].
!
async testValueAwait
	| result |

	result := await async [ await 1 + 2 ] valueAwait.
	self assert: [ result = 3 ].

	result := await async [ :a | await a + a ] valueAwait: 3.
	self assert: [ result = 6 ].

	result := await async [ :a :b | await a + b ] valueAwait: 3 value: 2.
	self assert: [ result = 5 ].
!
async testWhileTrueAwait
	| milliseconds num |

	milliseconds := Date new.
	await async [ await Timer timeout: 10.
			Date new <= milliseconds ] whileTrueAwait.
	self assert: [ Date new > milliseconds ].

	num := 0.
	await [ num < 3 ] whileTrueAwait:
		async [ await Timer timeout: 10.
			num := num + 1. ].
	self assert: [ num = 3 ].
!

testTryCatch
	| result |
	result := [ Object missingMethod ]
		tryCatch: [ :error | self onTryCatch: error ].
	self assert: [ result = 'caught' ].
!
onTryCatch: error
	self assert: [ error message includes: 'is not a function' ].
	^ 'caught'.
!
async testTryAwaitCatch
	| result |
	result := await async [ Object missingMethod ]
		tryAwaitCatch: [ :error | self onTryCatch: error ].
	self assert: [ result = 'caught' ].
!
