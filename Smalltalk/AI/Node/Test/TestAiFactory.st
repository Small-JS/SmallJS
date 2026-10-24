CLASS TestAiFactory EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Tests the common chat interface of all AI providers."

async test
	"Awaited one by one, so a failed assertion fails this test."
	await self testAi: 'ollama'.
	await self testAi: 'openai'.
	await self testAi: 'deepseek'.
	await self testAi: 'googleai'.
	await self testAi: 'anthropic'.
!
async testAi: name
	| ai response |
	( AiFactory available: name ) ifFalse: [ ^ false ].

	ai := AiFactory new: name.
	response := await ai chat: #( 'Say exactly: This is a test' ).
	self assert: [ response toLowerCase includes: 'test'  ].
!
