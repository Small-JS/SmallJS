CLASS McpServer EXTENDS JsObject MODULE MyMcpApp CLASSVARS ''
	VARS 'stdioHandle'

"This class wraps the McpServer class of the MCP TypeScript SDK v2.
 Variable 'js' contains the JS McpServer instance."

INLINE 'import * as mcpServer$ from "@modelcontextprotocol/server";'
INLINE 'import * as mcpStdio$ from "@modelcontextprotocol/server/stdio";'
INLINE 'import * as zod$ from "zod/v4";'

CLASSMETHODS

"Creating"

name: name version: version
	^ self fromJs: INLINE 'new mcpServer$.McpServer( { name: name.js, version: version.js } )'.
!

METHODS

"Tools"

registerTool: name description: description stringArguments: argumentNames then: block
	"Register a tool whose input arguments are all required strings.
	 Calls with missing or non-string arguments are rejected by the SDK with an error result.
	 Block may be async. It should take 1 argument, a JsObject with the input arguments,
	 that can be read with atJsProperty:, and return the text content of the result,
	 a String, or another object that is converted with toString."

	INLINE 'this.js.registerTool(
		name.js,
		{
			description: description.js,
			inputSchema: zod$.object( Object.fromEntries(
				argumentNames.$toJs().map( argumentName => [ argumentName, zod$.string() ] ) ) )
		},
		async ( args ) => ( {
			content: [ { type: "text",
				text: ( await block.js( stJsObject$class.$fromJs$( args ) ) ).$toString().js } ]
		} ) )'.
!

"Connecting"

async connect: transport
	"Attach to transport, a JsObject wrapping a JS MCP Transport, and start listening for messages."
	INLINE 'await this.js.connect( transport.js )'.
!
async close
	"Close the connection."
	INLINE 'await this.js.close()'.
!

"Stdio"

serveStdio
	"Serve MCP over stdin/stdout with this server, until closeStdio."
	stdioHandle := JsObject fromJs: INLINE 'mcpStdio$.serveStdio( () => this.js )'.
!
async closeStdio
	"Close the stdio connection and the server pinned to it. Does nothing when not serving."
	| handle |
	handle := stdioHandle.
	stdioHandle := nil.
	INLINE 'await handle?.js?.close()'.
!
isServingStdio
	^ stdioHandle notNil.
!
