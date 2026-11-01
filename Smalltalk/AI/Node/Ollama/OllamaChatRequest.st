CLASS OllamaChatRequest EXTENDS JsObject MODULE AiOllama CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

model: model
	INLINE 'this.js.model = model.js'.
!
addRole: role content: content
	self addMessage: ( OllamaMessage new role: role; content: content ).
!
addMessage: message
	INLINE 'if( ! this.js.messages ) this.js.messages = []'.
	INLINE 'this.js.messages.push( message.js )'.
!
messages
	"Answer an Array of OllamaMessage."
	^ Array fromJs: INLINE 'this.js.messages ?? []' elementClass: OllamaMessage.
!
tools: tools
	"Set the tools the model may call: an Array of OllamaTool.
	 The model must support tool calling."
	INLINE 'this.js.tools = tools.$toJs()'.
!
