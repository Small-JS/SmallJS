CLASS MyMcpApp EXTENDS Object MODULE MyMcpApp CLASSVARS ''
	VARS 'mcpClient ollama tools calledToolNames'

"MCP host app: asks a question to an LLM in Ollama, with the tools of the MCP server MyMcpServer.
 The server is started as a child process (this script with argument -server)
 and called over its stdin and stdout.
 When the LLM asks to call a tool, the app calls it on the server and passes the result back to the LLM,
 until the LLM gives its final answer.
 It is tested by TestMyMcpApp."

async start
	await self connect.
	await self ask: 'What is the weather forecast for Amsterdam?'.
	await self close.
!

"Connecting"

async connect
	"Start the MCP server as a child process, connect to it and convert its tools for Ollama."
	| transport mcpTools |
	transport := McpClient
		stdioTransportCommand: Process execPath
		arguments: ( Array with: ( Process argv at: 1 ) with: '-server' ).
	mcpClient := McpClient name: 'weather-host' version: '1.0.0'.
	await mcpClient connect: transport.

	mcpTools := await mcpClient listTools.
	tools := mcpTools map: [ :mcpTool |
		OllamaTool
			name: mcpTool name
			description: mcpTool description
			parameters: mcpTool inputSchema ].
	ollama := Ollama new.
	calledToolNames := Array new.
!
async close
	"Close the connection, which also stops the server child process."
	await mcpClient close.
!

"Asking"

async ask: question
	"Ask the LLM the question, with the MCP tools. Answer the final answer text of the LLM."
	| request message |
	Console log: 'Question: ', question.
	request := OllamaChatRequest new
		model: ollama model;
		tools: tools;
		addRole: 'user' content: question.
	message := ( await ollama chatRequest: request ) message.

	await [ message toolCalls isEmpty not ] whileTrueAwait: async [
		request addMessage: message.
		await message toolCalls doAwait: async [ :toolCall |
			request addMessage: ( await self callTool: toolCall ) ].
		message := ( await ollama chatRequest: request ) message ].

	Console log: 'Answer: ', message content.
	^ message content.
!
async callTool: toolCall
	"Call the tool on the MCP server. Answer an OllamaMessage with the result for the LLM."
	| text |
	Console log: 'Tool call: ', toolCall name, ' ', ( toolCall arguments toJson ).
	text := await mcpClient callToolText: toolCall name arguments: toolCall arguments.
	Console log: 'Tool result: ', text.
	calledToolNames add: toolCall name.
	^ OllamaMessage new
		role: 'tool';
		toolName: toolCall name;
		content: text.
!

"Accessing - used in tests"

mcpClient
	^ mcpClient.
!
calledToolNames
	"Answer an Array with the names of the tools called by the LLM, in order."
	^ calledToolNames.
!
