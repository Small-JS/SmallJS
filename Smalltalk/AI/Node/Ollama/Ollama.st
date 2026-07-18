CLASS Ollama EXTENDS Ai MODULE AiOllama CLASSVARS '' VARS ''

INLINE 'import { Ollama } from "ollama";'

CLASSMETHODS

new
	^ self new: OllamaConfig new.
!
new: config
	^ self fromJs: INLINE 'new Ollama( config.js )'.
!

METHODS

"Chat"

async chat: messages
	| request response |
	request := OllamaChatRequest new
		model: self model.
	messages do: [ :message |
		request addRole: 'user' content: message ].

	response := await self chatRequest: request.
	^ response message content.
!
async chatRequest: request
	^ OllamaChatResponse fromJs: INLINE 'await this.js.chat( request.js )'.
!

"Embedding"

async embed: request
	^ OllamaEmbedResponse fromJs: INLINE 'await this.js.embed( request.js )'.
!

"Accessing"

config
	^ OllamaConfig fromJs: INLINE 'this.js.config'.
!
