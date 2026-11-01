# Code

## main.ts

The entry point. With the argument `-test` it starts `TestMyMcpApp`,\
otherwise it starts `MyMcpApp`.

## MyMcpApp

This is the main app class.\
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

## McpClient

Class `McpClient` wraps the `Client` class of the MCP client SDK.\
It has methods to connect to a server, list its tools and call a tool.\
It can create 2 kinds of transports:
- A linked in-memory pair, for a client and server in the same process.
- A stdio transport, that starts the server as a child process.

## TestMyMcpApp

This class tests the app with an `McpClient`, first in memory, then over stdio.\
It checks the tool list, a tool call, and a call without the required argument.\
Errors are not caught, so the test halts immediately on the first error.

## Finished

That was all, hope you had fun. Or go back to [MCP.md](../MCP.md)
