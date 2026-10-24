CLASS TestAiChatRequest EXTENDS Test MODULE TestAiShared CLASSVARS '' VARS ''

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

	"Query parameter values are URL-encoded."
	request messages: #( 'A & B #1 + 50%?' ).
	self assert: [ request toUrlQuery =
		'?provider=openai&model=gpt-4o&messages=%5B%22A%20%26%20B%20%231%20%2B%2050%25%3F%22%5D' ].

	object := Object new
		atProperty: 'provider' put: 'deepthought';
		atProperty: 'model' put: 'universal';
		atProperty: 'messages' put: '["The question of life"]'.
	request := AiChatRequest fromObject: object.
	self assert:[ request provider = 'deepthought' ].
	self assert:[ request model = 'universal' ].
	self assert:[ request messages = #( 'The question of life' ) ].

	"Missing messages give nil, invalid messages JSON raises an error."
	request := AiChatRequest fromObject: Object new.
	self assert:[ request provider isNil ].
	self assert:[ request messages isNil ].
	object atProperty: 'messages' put: '["unterminated'.
	self assertError: [ AiChatRequest fromObject: object ].
!
