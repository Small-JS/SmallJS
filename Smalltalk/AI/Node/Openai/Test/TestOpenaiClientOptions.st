CLASS TestOpenaiClientOptions EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| openai options |

	options := OpenaiClientOptions new.
	self assert: [ options class = OpenaiClientOptions ].

	self assert: [ options baseUrl = ( Process envAt: 'OPENAI_BASE_URL' ) ].
	self assert: [ options apiKey = ( Process envAt: 'OPENAI_API_KEY' ) ].
	self assert: [ options organization = ( Process envAt: 'OPENAI_ORGANIZATION' ) ].
	self assert: [ options project = ( Process envAt: 'OPENAI_PROJECT' ) ].

	options baseUrl: 'https://api.openai.com/v1'.
	self assert: [ options baseUrl = 'https://api.openai.com/v1' ].

	options apiKey: 'sk-proj-mySecretApiKey'.
	self assert: [ options apiKey = 'sk-proj-mySecretApiKey' ].

	options organization: 'SmallJS'.
	self assert: [ options organization = 'SmallJS' ].

	options project: 'AI for SmallJS'.
	self assert: [ options project = 'AI for SmallJS' ].

	openai := Openai new: options.
	self assert: [ openai class = Openai ].
	self assert: [ openai apiKey = options apiKey ].
	self assert: [ openai organization = options organization ].
	self assert: [ openai project = options project ].
!
