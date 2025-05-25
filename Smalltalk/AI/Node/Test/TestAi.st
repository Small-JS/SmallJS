CLASS TestAi EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	#( 'openai' 'deepseek' 'googleai' 'anthropic' ) do: [ :name |
		self testAi: name ]
!
testAi: name
	| ai |
	( Ai available: name ) ifFalse: [ ^ false ].
	ai := Ai new: name.

	ai chat: #( 'Say exactly: This is a test' )
		then: [ :response | self onChat: response ].
!
onChat: response
	self assert: [ response toLowerCase includes: 'test'  ].
!
