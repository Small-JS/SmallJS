CLASS TestAiChatRequest EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| request object |

	request := AiChatRequest new
		provider: 'openai';
		model: 'gpt-4o';
		messages: #( 'Say this is a test' ).
	self assert:[ request provider = 'openai' ].
	self assert:[ request model = 'gpt-4o' ].
	self assert:[ request messages = #( 'Say this is a test' ) ].
	self assert: [ request toString = 'AiChatRequest( provider: openai, model: gpt-4o, messages: "#( Say this is a test )" )' ].

	object := Object new
		atProperty: 'provider' put: 'deepthought';
		atProperty: 'model' put: 'universal';
		atProperty: 'messages' put: '["The question of life"]'.
	request := AiChatRequest fromObject: object.
	self assert:[ request provider = 'deepthought' ].
	self assert:[ request model = 'universal' ].
	self assert:[ request messages = #( 'The question of life' ) ].
!
