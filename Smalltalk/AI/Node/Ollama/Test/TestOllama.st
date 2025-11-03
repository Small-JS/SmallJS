CLASS TestOllama EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Also tests classes: OllamaChatRequest, OllamaChatResponse."

disabled
	^ Ollama available not.
!
async test
	| ollama request response message |

	ollama := Ollama new.
	self assert: [ ollama config host startsWith: 'http' ].

	request := OllamaChatRequest new
		model: ollama model;
		addRole: 'user' content: 'Say exactly: This is a test'.

	response := await ollama chatRequest: request.
	self assert: [ response class = OllamaChatResponse ].
	self assert: [ response model = ollama model ].
	self assert: [ response createdAt toSeconds > ( Date new toSeconds - 60 ) ].
	self assert: [ response done ].
	self assert: [ response doneReason = 'stop' ].
	self assert: [ response evalCount > 0 ].
	self assert: [ response evalDuration > 0 ].
	self assert: [ response promptEvalCount > 0 ].
	self assert: [ response promptEvalDuration > 0 ].
	self assert: [ response totalDuration > 0 ].

	message := response message.
	self assert: [ message role = 'assistant' ].
	self assert: [ message content toLowerCase includes: 'test' ].
!
