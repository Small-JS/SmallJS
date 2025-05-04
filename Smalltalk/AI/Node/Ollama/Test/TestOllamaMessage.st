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
