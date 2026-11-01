CLASS McpTool EXTENDS JsObject MODULE MyMcpApp CLASSVARS '' VARS ''

"A tool of an MCP server, as listed by McpClient>>listTools.
 Wraps a JS MCP Tool: { name, description, inputSchema }."

"Accessing"

name
	^ String fromJs: INLINE 'this.js.name'.
!
description
	^ String fromJs: INLINE 'this.js.description ?? ""'.
!
inputSchema
	"Answer a JsObject with the JSON Schema of the input arguments of the tool."
	^ JsObject fromJs: INLINE 'this.js.inputSchema'.
!
