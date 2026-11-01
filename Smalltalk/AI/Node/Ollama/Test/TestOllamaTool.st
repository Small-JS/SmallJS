CLASS TestOllamaTool EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| parameters tool |

	parameters := JsObject newEmpty atJsProperty: 'type' put: 'object'.
	tool := OllamaTool
		name: 'get-forecast'
		description: 'Get the weather forecast for a city'
		parameters: parameters.
	self assert: [ tool class = OllamaTool ].
	self assert: [ tool name = 'get-forecast' ].
	self assert: [ tool description = 'Get the weather forecast for a city' ].
	self assert: [ ( tool parameters atJsProperty: 'type' ) = 'object' ].
	self assert: [ ( tool atJsProperty: 'type' ) = 'function' ].
!
