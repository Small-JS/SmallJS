CLASS TestMyMcpApp EXTENDS Object MODULE TestMyMcpApp CLASSVARS ''
	VARS 'myMcpApp mcpClient'

"MyMcpApp test: runs the tool tests with an MCP client connected in two ways:
- In memory: to the app's server in this process, over a linked in-memory transport pair.
- Over stdio: to the app started as a child process, over its stdin and stdout.
This class is not a subclass of Test so is not called automatically with Test all."

async start
	myMcpApp := MyMcpApp new.
	await self testInMemory.
	await self testStdio.
	Console log: 'TestMyMcpApp passed.'.
!

"Connections"

async testInMemory
	| transports |
	myMcpApp createServer.
	transports := McpClient linkedTransportPair.
	await myMcpApp mcpServer connect: ( transports at: 1 ).

	mcpClient := McpClient name: 'test-client' version: '1.0.0'.
	await mcpClient connect: ( transports at: 0 ).

	await self testClient.
	await myMcpApp mcpServer close.
!
async testStdio
	"Start this script (main.js) again without -test, so the child process runs MyMcpApp."
	| transport |
	transport := McpClient
		stdioTransportCommand: Process execPath
		arguments: ( Array with: ( Process argv at: 1 ) ).

	mcpClient := McpClient name: 'test-client' version: '1.0.0'.
	await mcpClient connect: transport.

	await self testClient.
!
async testClient
	"Run the tool tests with the connected client, then close it.
	 Errors are not caught, so the test halts immediately on the first error."
	await self testListTools.
	await self testCallTool.
	await self testCallToolWithoutCity.
	await mcpClient close.
!

"Tests"

async testListTools
	| names |
	names := await mcpClient listToolNames.
	Console log: 'Received tool names: ', names toString.
	self assert: [ names = #( 'get-forecast' ) ].
!
async testCallTool
	| text |
	text := await mcpClient
		callToolText: 'get-forecast'
		arguments: ( JsObject newEmpty atJsProperty: 'city' put: 'Amsterdam' ).
	Console log: 'Received tool text: ', text.
	self assert: [ text = 'Sunny in Amsterdam all week.' ].
!
async testCallToolWithoutCity
	"The SDK rejects the call, because the required argument 'city' is missing."
	| error |
	error := await async [
		await mcpClient callToolText: 'get-forecast' arguments: JsObject newEmpty.
		nil ]
		tryAwaitCatch: [ :caught | caught ].
	self assert: [ error notNil ].
	Console log: 'Received expected error: ', error message.
!
