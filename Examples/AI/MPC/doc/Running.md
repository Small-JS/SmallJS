# Running

## Build and test

Run the script `build.sh` .\
It compiles the TypeScript and SmallJS code and then runs the tests.\
If all went well the last message is: `TestMyMcpApp passed.`

The tests call the tool with an MCP client in two ways:
- In memory: with the server in the same process.
- Over stdio: with the app started as a child process.

The tests can also be run in VSCode:\
open the workspace `MCP.code-workspace`,\
click the `Run and Debug` triangle-with-bug on the left of the screen,\
select the configuration `Launch Test` and click the green triangle to `Start Debugging`.

## Interactive

Start the server with the script `start.sh`,\
or in VSCode with the configuration `Launch App`.\
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

## From an MCP host

An MCP host that supports stdio servers can start this app.\
Configure it with the command `node` and the argument:\
the absolute path to `out/main.js` of this project.\
For example, in a JSON configuration file:

```
"mcpServers": {
	"weather": {
		"command": "node",
		"args": [ "<path to this project>/out/main.js" ]
	}
}
```

## Next step

Now that everything is working, let's check out the [Code.md](Code.md)
