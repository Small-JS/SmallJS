CLASS McpClient EXTENDS JsObject MODULE MyMcpApp CLASSVARS ''
	VARS ''
	"This class wraps the Client class of the MCP TypeScript SDK v2 (npm module '@modelcontextprotocol/client').
	 Variable 'js' contains the JS Client instance."

INLINE 'import * as mcpClient$ from "@modelcontextprotocol/client";'
INLINE 'import * as mcpClientStdio$ from "@modelcontextprotocol/client/stdio";'

CLASSMETHODS

"Creating"

name: name version: version
	^ self fromJs: INLINE 'new mcpClient$.Client( { name: name.js, version: version.js } )'.
!

"Transports"

linkedTransportPair
	"Answer an Array of 2 linked in-memory transports (JsObjects), for an in-process client and server.
	 Element 0 is for the client, element 1 for the server (McpServer>>connect:)."
	| pair |
	pair := INLINE 'mcpClient$.InMemoryTransport.createLinkedPair()'.
	^ Array
		with: ( JsObject fromJs: INLINE 'pair[ 0 ]' )
		with: ( JsObject fromJs: INLINE 'pair[ 1 ]' ).
!
stdioTransportCommand: command arguments: commandArguments
	"Answer a transport (JsObject) that runs command with commandArguments (an Array of Strings)
	 as a child process, and talks MCP over its stdin and stdout.
	 The child process is started by connect: and stopped by close.
	 Its stderr is passed through to the stderr of this process."
	^ JsObject fromJs: INLINE 'new mcpClientStdio$.StdioClientTransport(
		{ command: command.js, args: commandArguments.$toJs() } )'.
!

METHODS

"Connecting"

async connect: transport
	"Connect to a server over transport, a JsObject wrapping a JS MCP Transport."
	INLINE 'await this.js.connect( transport.js )'.
!
async close
	"Close the connection."
	INLINE 'await this.js.close()'.
!

"Tools"

async listToolNames
	"Answer an Array with the names of the tools of the server."
	^ Array fromJsStrings: INLINE '( await this.js.listTools() ).tools.map( tool => tool.name )'.
!
async callTool: name arguments: toolArguments
	"Call tool name with toolArguments, a JsObject with the input arguments.
	 Answer the JS CallToolResult as a JsObject."
	^ JsObject fromJs: INLINE 'await this.js.callTool( { name: name.js, arguments: toolArguments.js } )'.
!
async callToolText: name arguments: toolArguments
	"Call tool name with toolArguments, a JsObject with the input arguments.
	 Answer the text content of the result as a String.
	 Throw an Error with that text if the server answers with an error result."
	| result text |
	result := await self callTool: name arguments: toolArguments.
	text := String fromJs:
		INLINE 'result.js.content
			.filter( content => content.type === "text" )
			.map( content => content.text ).join( "" )'.
	( result atJsProperty: 'isError' ) = true ifTrue: [ Error throw: text ].
	^ text.
!
