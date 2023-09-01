CLASS TestBlock EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| milliseconds |
	self assert: [ [ 1 + 2 ] value = 3 ].
	self assert: [ ( [ :a | a squared ] value: 3 ) = 9 ].
	self assert: [ ( [ :a :b | a * b ] value: 3 value: 4 ) = 12 ].
	self assert: [ [ true ] and: [ true ] ].
	self assert: [ [ false ] or: [ true ] ].
	self assert: [ ( [ :x | x + 1 ] script ) includes: 'x.$$plus' ].
	self assert: [ ( [ Object thisMethodDoesNotExist ] valueOnError: [ :error | 'caught'] ) = 'caught' ].

	milliseconds := Date new.
	[ Date new <= milliseconds ] whileTrue.
!
