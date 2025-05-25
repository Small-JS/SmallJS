CLASS Ollama EXTENDS Ai MODULE Ai CLASSVARS '' VARS ''

INLINE 'import { Ollama } from "ollama";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Ollama()'.
!
new: config
	^ self fromJs: INLINE 'new Ollama( config.js )'.
!

METHODS

"Chat"

chat: messages then: block
	| request |
	request := OllamaChatRequest new
		model: self model.
	messages do: [ :message |
		request addRole: 'user' content: message ].

	self chatRequest: request
		then: [ :response | self onChat: response then: block ].
!
onChat: response then: block
	block value: response message content.
!
chatRequest: request then: block
	INLINE 'this.js.chat( request.js )
			.then( response => block.$value$( stOllamaChatResponse$class.$fromJs$( response ) ) )'.
!

"Accessing"

config
	^ OllamaConfig fromJs: INLINE 'this.js.config'.
!
