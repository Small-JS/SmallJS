CLASS OllamaTool EXTENDS JsObject MODULE AiOllama CLASSVARS '' VARS ''

"A tool that an Ollama model may call, passed with OllamaChatRequest>>tools:.
 Wraps a JS object: { type: 'function', function: { name, description, parameters } }."

CLASSMETHODS

"Creating"

name: name description: description parameters: parameters
	"Parameters is a JsObject with the JSON Schema of the input arguments of the tool."
	^ self fromJs: INLINE '{ type: "function",
		function: { name: name.js, description: description.js, parameters: parameters.js } }'.
!

METHODS

"Accessing"

name
	^ String fromJs: INLINE 'this.js.function.name'.
!
description
	^ String fromJs: INLINE 'this.js.function.description'.
!
parameters
	^ JsObject fromJs: INLINE 'this.js.function.parameters'.
!
