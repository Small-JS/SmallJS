CLASS TestAi EXTENDS Test MODULE AiTest CLASSVARS '' VARS ''

test
	#( 'openai' 'deepseek' 'googleai' ) do: [ :name |
		self testAi: name ]
!
testAi: name
	| ai |
	( Ai available: name ) ifFalse: [ ^ false ].
	ai := Ai new: name.

	ai chat: 'Say this is a test'
		then: [ :response | self onChat: response ].
!
onChat: response
	self assert: [ response toLowerCase includes: 'this is a test'  ].
!
