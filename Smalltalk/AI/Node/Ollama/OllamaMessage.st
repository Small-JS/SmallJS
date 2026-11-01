CLASS OllamaMessage EXTENDS JsObject MODULE AiOllama CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

role
 	^ String fromJs: INLINE 'this.js.role'.
!
role: role
 	INLINE 'this.js.role = role.js'.
!
content
 	^ String fromJs: INLINE 'this.js.content'.
!
content: content
 	INLINE 'this.js.content = content.js'.
!
toolCalls
	"Answer an Array of OllamaToolCall: the tools the model asks to call. Empty if none."
	^ Array fromJs: INLINE 'this.js.tool_calls ?? []' elementClass: OllamaToolCall.
!
toolCalls: toolCalls
	"ToolCalls is an Array of OllamaToolCall."
	INLINE 'this.js.tool_calls = toolCalls.$toJs()'.
!
toolName
	"The name of the tool whose result is in content, for role 'tool'."
	^ String fromJs: INLINE 'this.js.tool_name'.
!
toolName: toolName
	INLINE 'this.js.tool_name = toolName.js'.
!
