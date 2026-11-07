CLASS TestPlayground EXTENDS Test MODULE TestPlaygroundApp CLASSVARS '' VARS ''

"Helpers"

async evaluate: expression
	"Answer the result of evaluating expression, or the error if evaluation fails."
	| evaluating |
	evaluating := Promise new: [ :resolve :reject |
		Playground new evaluate: expression
			onResult: [ :result | resolve value: result ]
			onError: [ :error | resolve value: error ] ].
	^ await evaluating js.
!

"Tests"

async testResult
	| result |
	result := await self evaluate: '1 + 2'.
	self assert: [ result = 3 ].
!
async testCompileError
	"Compile errors must be reported as an error, not hang or fail silently."
	| result |
	result := await self evaluate: '#( 1 2'.
	self assert: [ result class = Error ].
	self assert: [ result message includes: 'Compile error' ].

	result := await self evaluate: '\'abc'.
	self assert: [ result class = Error ].
	self assert: [ result message includes: 'Compile error' ].

	result := await self evaluate: 'Foo new'.
	self assert: [ result class = Error ].
	self assert: [ result message includes: 'Cannot find class reference: Foo' ].
!
async testRuntimeError
	| result |
	result := await self evaluate: 'nil foo'.
	self assert: [ result class = Error ].
!
