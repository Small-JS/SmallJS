CLASS MyMcpApp EXTENDS Object MODULE MyMcpApp CLASSVARS ''
	VARS 'mcpServer'

"Simple MCP server app with one tool: 'get-forecast'.
 It serves MCP over stdio. It is tested by TestMyMcpApp."

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
