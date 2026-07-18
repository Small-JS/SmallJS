CLASS TestAiFactory EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Tests the common chat interface of all AI provivers."

test
	#( 'ollama' "'openai' 'deepseek' 'googleai' 'anthropic'" )
		do: [ :name | self testAi: name ]
!
async testAi: name
	| ai response |
	( AiFactory available: name ) ifFalse: [ ^ false ].

	ai := AiFactory new: name.
	response := await ai chat: #( 'Say exactly: This is a test' ).
	self assert: [ response toLowerCase includes: 'test'  ].
!
