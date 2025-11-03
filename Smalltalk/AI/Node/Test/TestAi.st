CLASS TestAi EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Tests the common chat interface of all AI provivers."

test
	#( 'ollama' 'openai' 'deepseek' 'googleai' 'anthropic' ) do: [ :name |
		self testAi: name ]
!
async testAi: name
	| ai response |
	( Ai available: name ) ifFalse: [ ^ false ].

	ai := Ai new: name.
	response := await ai chat: #( 'Say exactly: This is a test' ).
	self assert: [ response toLowerCase includes: 'test'  ].
!
