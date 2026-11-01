CLASS TestOllamaToolCall EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| toolCall |

	toolCall := OllamaToolCall
		name: 'get-forecast'
		arguments: ( JsObject newEmpty atJsProperty: 'city' put: 'Amsterdam' ).
	self assert: [ toolCall class = OllamaToolCall ].
	self assert: [ toolCall name = 'get-forecast' ].
	self assert: [ ( toolCall arguments atJsProperty: 'city' ) = 'Amsterdam' ].
!
