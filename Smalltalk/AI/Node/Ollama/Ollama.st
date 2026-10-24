CLASS Ollama EXTENDS Ai MODULE AiOllama CLASSVARS '' VARS ''

INLINE 'import { Ollama } from "ollama";'

CLASSMETHODS

new
	^ self new: OllamaConfig new.
!
new: config
	^ self fromJs: INLINE 'new Ollama( config.js )'.
!

"Configuration"

requiresApiKey
	"Ollama runs locally without an API key."
	^ false.
!

METHODS

"Chat"

async chat: messages model: aModel
	| request response |
	request := OllamaChatRequest new
		model: aModel.
	0 to: messages length - 1 do: [ :index |
		request addRole: ( self roleAt: index ) content: ( messages at: index ) ].

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
