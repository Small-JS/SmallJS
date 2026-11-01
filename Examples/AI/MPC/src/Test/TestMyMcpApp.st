CLASS TestMyMcpApp EXTENDS Object MODULE TestMyMcpApp CLASSVARS ''
	VARS 'myMcpApp'

"MyMcpApp test: connects the app to its MCP server (a child process over stdio)
 and asks Ollama a question that it should answer by calling the MCP tool.
 This class is not a subclass of Test so is not called automatically with Test all.
 Errors are not caught, so the test halts immediately on the first error."

async start
	myMcpApp := MyMcpApp new.
	await myMcpApp connect.
	await self testListTools.
	await self testAsk.
	await myMcpApp close.
	Console log: 'TestMyMcpApp passed.'.
!

"Tests"

async testListTools
	| names |
	names := await myMcpApp mcpClient listToolNames.
	Console log: 'Received tool names: ', names toString.
	self assert: [ names = #( 'get-forecast' ) ].
!
async testAsk
	"The LLM should call the tool and use its result. LLM answers vary, so only check for the forecast."
	| answer |
	answer := await myMcpApp ask: 'What is the weather forecast for Amsterdam?'.
	self assert: [ myMcpApp calledToolNames includes: 'get-forecast' ].
	self assert: [ answer toLowerCase includes: 'sunny' ].
!
