CLASS TestBoolean EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ true toString = 'true' ].
	self assert: [ false toString = 'false' ].

	self assert: [ true = true ].
	self assert: [ true ~= false ].

	self assert: [ false < true ].
	self assert: [ false <= true ].
	self assert: [ true > false ].
	self assert: [ true >= false ].

	self assert: [ true ifTrue: [ true ] ].
	self assert: [ ( false ifTrue: [ true ] ifFalse: [ false ] ) not ].
	self assert: [ false ifFalse: [ true ] ].
	self assert: [ ( false ifFalse: [ false ] ifTrue: [ true ] ) not ].

	self assert: [ true and: [ true ] ].
	self assert: [ ( true and: [ false ] ) not ].

	self assert: [ true or: [ false ] ].
	self assert: [ ( false or: [ false ] ) not ].

	self assert: [ true ].
	self assert: [ false not ].

	self assert: [ true & true ].
	self assert: [ ( true & false ) not ].

	self assert: [ true | false ].
	self assert: [ ( false | false ) not ].

!
async testAsyncAwait
	| trueBlock falseBlock result |
	trueBlock := async [ await Timer timeout: 1. true ].
	falseBlock := async [ await Timer timeout: 2. false ].

	"The result cannot go directly into asserts with sync blocks."
	self checkResult: ( await true ifTrueAwait: trueBlock ).
	self checkResult: ( ( await false ifTrueAwait: trueBlock ifFalseAwait: falseBlock ) not ).
	self checkResult: ( ( await false ifFalseAwait: falseBlock ) not ).
	self checkResult: ( await true ifFalseAwait: [ falseBlock ] ifTrueAwait: trueBlock ).
!
checkResult: result
	self assert: [ result ].
!
