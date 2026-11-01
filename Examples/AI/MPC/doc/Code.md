# Code

## main.ts

The entry point. With the argument `-test` it starts `TestMyMcpApp`,\
with the argument `-server` it starts `MyMcpServer`,\
otherwise it starts `MyMcpApp`.

## MyMcpApp

This is the main app class: the MCP host.\
It starts this app again with argument `-server` as a child process,\
and connects an `McpClient` to it over stdio.\
It converts the MCP tools of the server to Ollama tools (`OllamaTool`).

Then it asks the LLM in Ollama a question, with these tools.\
When the LLM answers with tool calls (`OllamaToolCall`),\
the app calls each tool on the MCP server,\
adds the results as messages with role `tool` to the chat,\
and asks the LLM again, until it gives a final answer without tool calls.

## MyMcpServer

The MCP server.\
It creates an `McpServer` with the tool `get-forecast`,\
that has one required string argument: `city`.\
Then it serves MCP over stdin and stdout.

Note that the server must never write anything else to stdout,\
because that would corrupt the MCP messages.\
Logging must go to stderr.

## McpServer

Class `McpServer` wraps the `McpServer` class of the MCP server SDK.\
It has methods to register a tool, to connect to a transport,\
and to serve MCP over stdio.\
The tool's input schema is created with Zod.\
The SDK rejects calls with missing or invalid arguments.

## McpClient and McpTool

Class `McpClient` wraps the `Client` class of the MCP client SDK.\
It has methods to connect to a server, list its tools (`McpTool`) and call a tool.\
It can create 2 kinds of transports:
- A stdio transport, that starts the server as a child process.
- A linked in-memory pair, for a client and server in the same process.

## Ollama classes

The Ollama classes are in the SmallJS library folder `Smalltalk/AI/Node/Ollama`.\
`OllamaChatRequest` holds the chat messages (`OllamaMessage`) and the tools (`OllamaTool`).\
An `OllamaMessage` from the LLM may contain tool calls (`OllamaToolCall`).

## TestMyMcpApp

This class tests the app: it checks the tool list of the server,\
and that the LLM calls the tool and uses its result in the answer.\
Errors are not caught, so the test halts immediately on the first error.

## Finished

That was all, hope you had fun. Or go back to [MCP.md](../MCP.md)
