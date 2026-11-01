# AI MCP example app

This is an educational app implementing a simple MCP server and host.

MCP stands for Model Context Protocol.\
It is an open protocol that lets an AI client, such as an LLM host,\
discover and call tools provided by a server.

This app has two parts:
- An MCP server with one tool: `get-forecast`.\
  It answers a (fake) weather forecast for a city.
- An MCP host, that asks an LLM in Ollama: `What is the weather forecast for Amsterdam?`,\
  passing it the tools of the server.\
  When the LLM asks to call the tool, the host calls it on the server\
  and passes the result back to the LLM, that then gives its final answer.

The host starts the server as a child process,\
and talks MCP to it over the server's stdin and stdout, as JSON-RPC messages, one per line.\
So the server can also be started by any other MCP host that supports stdio servers.

The app uses the official MCP TypeScript SDK v2,\
wrapped in the SmallJS classes `McpServer` and `McpClient`.\
Ollama runs the LLM locally, independent of cloud AI providers.

Note:\
For simplicity, this example app is self contained.\
For AI chat server and client apps, check out the `Server` and `Client` projects in the parent folder.

## Setup

### Ollama

Ollama is a LLM host that can run models locally.\
Ollama can be downloaded here:\
[https://ollama.com/download](https://ollama.com/download)

After Ollama is installed, open a terminal and install a model with:\
`ollama pull qwen3.5:4b`

The model must support tool calling.\
You could use other models, e.g. `qwen3` or `mistral`, but `qwen3.5:4b` is tested to work.

### npm packages

Install the npm packages with the script `install.sh` .

### Environment

Copy the file `.env.example` to `.env` and update that to match your configuration,\
e.g. the Ollama model that was installed.

## Running

Then build, test and run the app.\
It's described in [Running.md](doc/Running.md).

## Code

When everything ran, check out the code to see how it works.\
It's described here: [Code.md](doc/Code.md).

## Have fun!
