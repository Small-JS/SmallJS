CLASS TestAiChatRequest EXTENDS Test MODULE TestAiShared CLASSVARS '' VARS ''

test
	| request object request2 |

	request := AiChatRequest new
		provider: 'openai';
		model: 'gpt-4o';
		messages: #( 'Say this is a test' ).
	self assert:[ request provider = 'openai' ].
	self assert:[ request model = 'gpt-4o' ].
	self assert:[ request messages = #( 'Say this is a test' ) ].
	self assert: [ request toString = 'AiChatRequest( provider: openai, model: gpt-4o, messages: "#( Say this is a test )" )' ].

	"Round trip through JSON, as sent from client to server."
	request messages: #( 'A & B #1 + 50%?' 'An answer' 'Next "question"' ).
	request2 := AiChatRequest fromObject: ( Object fromJson: request toObject toJson ).
	self assert:[ request2 provider = 'openai' ].
	self assert:[ request2 model = 'gpt-4o' ].
	self assert:[ request2 messages = request messages ].

	object := Object new
		atProperty: 'provider' put: 'deepthought';
		atProperty: 'model' put: 'universal';
		atProperty: 'messages' put: #( 'The question of life' ).
	request := AiChatRequest fromObject: object.
	self assert:[ request provider = 'deepthought' ].
	self assert:[ request model = 'universal' ].
	self assert:[ request messages = #( 'The question of life' ) ].
	self assert:[ request messagesError isNil ].

	"Missing properties give nil."
	request := AiChatRequest fromObject: Object new.
	self assert:[ request provider isNil ].
	self assert:[ request messages isNil ].
	self assert:[ request messagesError = 'missing' ].

	request messages: 5.
	self assert:[ request messagesError = 'not an array' ].
	request messages: #( 'Question' 5 ).
	self assert:[ request messagesError = 'not an array of strings' ].
	request messages: #().
	self assert:[ request messagesError = 'not ending with a question' ].
	request messages: #( 'Question' 'Answer' ).
	self assert:[ request messagesError = 'not ending with a question' ].
!
