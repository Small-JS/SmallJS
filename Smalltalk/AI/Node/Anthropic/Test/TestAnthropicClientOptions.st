CLASS TestAnthropicClientOptions EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| anthropic options |

	options := AnthropicClientOptions new.
	self assert: [ options class = AnthropicClientOptions ].

	self assert: [ options baseUrl = ( Process envAt: 'ANTHROPIC_BASE_URL' ) ].
	self assert: [ options apiKey = ( Process envAt: 'ANTHROPIC_API_KEY' ) ].

	options baseUrl: 'https://api.anthropic.com/newBaseUrl'.
	self assert: [ options baseUrl = 'https://api.anthropic.com/newBaseUrl' ].

	options apiKey: 'sk-proj-mySecretApiKey'.
	self assert: [ options apiKey = 'sk-proj-mySecretApiKey' ].

	options maxRetries: 3.
	self assert: [ options maxRetries = 3 ].

	options timeout: 5000.
	self assert: [ options timeout = 5000 ].

	anthropic := Anthropic new: options.
	self assert: [ anthropic class = Anthropic ].
	self assert: [ anthropic baseUrl = options baseUrl ].
	self assert: [ anthropic apiKey = options apiKey ].
	self assert: [ anthropic maxRetries = options maxRetries ].
	self assert: [ anthropic timeout = options timeout ].
!
