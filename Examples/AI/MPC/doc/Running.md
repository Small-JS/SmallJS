# Running

## Build and test

Run the script `build.sh` .\
It compiles the TypeScript and SmallJS code, starts Ollama and then runs the tests.\
The test asks the LLM for the weather forecast and checks that it called the MCP tool.\
If all went well the last message is: `TestMyMcpApp passed.`

The tests can also be run in VSCode, if Ollama is running.\
Ollama can be started with the script: `startOllama.sh` .\
Open the workspace `MCP.code-workspace`,\
click the `Run and Debug` triangle-with-bug on the left of the screen,\
select the configuration `Launch Test` and click the green triangle to `Start Debugging`.

## App

First make sure that Ollama is running, e.g. with the script: `startOllama.sh` .\
Then start the app with the script `start.sh`,\
or in VSCode with the configuration `Launch App`.

If all went well the console shows messages like:

```
Question: What is the weather forecast for Amsterdam?
Tool call: get-forecast {"city":"Amsterdam"}
Tool result: Sunny in Amsterdam all week.
Answer: <an answer based on the tool result: sunny in Amsterdam all week>
```

LLM answers vary, and small models may add details that were not in the tool result.

## Server only

The MCP server can also be run on its own,\
with `node out/main.js -server` or in VSCode with the configuration `Launch Server`.\
It does not need Ollama.\
The server now waits for MCP JSON-RPC messages on stdin, one per line.\
Type (or paste) these lines one by one:

```
{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"terminal","version":"1.0.0"}}}
{"jsonrpc":"2.0","method":"notifications/initialized"}
{"jsonrpc":"2.0","id":2,"method":"tools/list"}
{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"get-forecast","arguments":{"city":"Amsterdam"}}}
```

The last response should contain: `"text":"Sunny in Amsterdam all week."` .\
Close stdin (Ctrl+D, or Ctrl+Z and Enter on Windows) to stop the server.

## From another MCP host

An MCP host that supports stdio servers can start the server.\
Configure it with the command `node` and the arguments:\
the absolute path to `out/main.js` of this project, and `-server`.\
For example, in a JSON configuration file:

```
"mcpServers": {
	"weather": {
		"command": "node",
		"args": [ "<path to this project>/out/main.js", "-server" ]
	}
}
```

## Next step

Now that everything is working, let's check out the [Code.md](Code.md)
