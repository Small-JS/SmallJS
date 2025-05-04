CLASS TestOllamaConfig EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| config ollama |

	config := OllamaConfig new.
	self assert: [ config class = OllamaConfig ].

	self assert: [ config host startsWith: 'http' ].
	config host: 'http://localhost:11434'.
	self assert: [ config host = 'http://localhost:11434' ].

	ollama := Ollama new: config.
	self assert: [ ollama class = Ollama ].
	self assert: [ ollama config host = config host ].
!
