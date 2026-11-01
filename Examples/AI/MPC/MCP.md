# AI MCP example app

This is an educational app implementing a simple MCP server.

MCP stands for Model Context Protocol.\
It is an open protocol that lets an AI client, such as an LLM host,\
discover and call tools provided by a server.

This app is an MCP server with one tool: `get-forecast`.\
It answers a (fake) weather forecast for a city.\
The server talks MCP over stdin and stdout, as JSON-RPC messages, one per line.\
So it can be started by any MCP host that supports stdio servers.

The app uses the official MCP TypeScript SDK v2,\
wrapped in the SmallJS classes `McpServer` and `McpClient`.

Note:\
For simplicity, this example app is self contained.\
For AI chat server and client apps, check out the `Server` and `Client` projects in the parent folder.

## Running

First install the npm packages with the script `install.sh` .\
Then build, test and run the server.\
It's described in [Running.md](doc/Running.md).

## Code

When everything ran, check out the code to see how it works.\
It's described here: [Code.md](doc/Code.md).

## Have fun!
