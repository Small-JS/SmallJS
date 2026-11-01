CLASS TestOllamaMessage EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| message |

	message := OllamaMessage new.
	self assert: [ message class = OllamaMessage ].

	message role: 'user'.
	self assert: [ message role = 'user' ].

	message content: 'Say: This is a test'.
	self assert: [ message content = 'Say: This is a test' ].
!
testTools
	| message toolCall |

	message := OllamaMessage new.
	self assert: [ message toolCalls isEmpty ].

	toolCall := OllamaToolCall
		name: 'get-forecast'
		arguments: ( JsObject newEmpty atJsProperty: 'city' put: 'Amsterdam' ).
	message toolCalls: ( Array with: toolCall ).
	self assert: [ message toolCalls length = 1 ].
	self assert: [ message toolCalls first class = OllamaToolCall ].
	self assert: [ message toolCalls first name = 'get-forecast' ].

	message toolName: 'get-forecast'.
	self assert: [ message toolName = 'get-forecast' ].
!
