CLASS MyMcpServer EXTENDS Object MODULE MyMcpApp CLASSVARS ''
	VARS 'mcpServer'

"Simple MCP server with one tool: 'get-forecast'.
 It serves MCP over stdio, when this script is started with argument -server.
 MyMcpApp starts it that way as a child process."

start
	self createServer.
	self startServer.
!

"Server"

createServer
	mcpServer := McpServer name: 'weather' version: '1.0.0'.
	mcpServer
		registerTool: 'get-forecast'
		description: 'Get the weather forecast for a city'
		stringArguments: #( 'city' )
		then: [ :arguments | self weatherForecastFor: arguments ].
!
weatherForecastFor: arguments
	| city |
	city := arguments atJsProperty: 'city'.
	^ 'Sunny in ', city, ' all week.'
!
startServer
	"Serve MCP over stdin/stdout."
	mcpServer serveStdio.
!
async stopServer
	"Close the stdio connection. Does nothing when not started."
	mcpServer isNil ifTrue: [ ^ self ].
	await mcpServer closeStdio.
!

"Accessing"

mcpServer
	^ mcpServer.
!
