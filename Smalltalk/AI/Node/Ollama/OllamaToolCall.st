CLASS OllamaToolCall EXTENDS JsObject MODULE AiOllama CLASSVARS '' VARS ''

"A tool call requested by an Ollama model, see OllamaMessage>>toolCalls.
 Wraps a JS object: { function: { name, arguments } }."

CLASSMETHODS

"Creating"

name: name arguments: toolArguments
	"ToolArguments is a JsObject with the input arguments of the tool."
	^ self fromJs: INLINE '{ function: { name: name.js, arguments: toolArguments.js } }'.
!

METHODS

"Accessing"

name
	^ String fromJs: INLINE 'this.js.function.name'.
!
arguments
	"Answer a JsObject with the input arguments, that can be read with atJsProperty:."
	^ JsObject fromJs: INLINE 'this.js.function.arguments'.
!
