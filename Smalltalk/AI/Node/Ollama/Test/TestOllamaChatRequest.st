CLASS TestOllamaChatRequest EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| request tool |

	request := OllamaChatRequest new.
	self assert: [ request messages isEmpty ].

	request
		addRole: 'user' content: 'What is the weather in Amsterdam?';
		addMessage: ( OllamaMessage new role: 'tool'; toolName: 'get-forecast'; content: 'Sunny' ).
	self assert: [ request messages length = 2 ].
	self assert: [ request messages first role = 'user' ].
	self assert: [ request messages last toolName = 'get-forecast' ].

	tool := OllamaTool
		name: 'get-forecast'
		description: 'Get the weather forecast for a city'
		parameters: JsObject newEmpty.
	request tools: ( Array with: tool ).
	self assert: [ ( request atJsProperty: 'tools' ) length = 1 ].
!
