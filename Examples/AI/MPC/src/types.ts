// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// MCP - Server
import * as McpServer from "@modelcontextprotocol/server";
let msServer: McpServer.McpServer;
let msImplementation: McpServer.Implementation;
let msTransport: McpServer.Transport;
let msCallToolResult: McpServer.CallToolResult;

// MCP - Server stdio
import * as mcpStdio from "@modelcontextprotocol/server/stdio";
let mstServeStdio: typeof mcpStdio.serveStdio;
let mstStdioServerHandle: mcpStdio.StdioServerHandle;
let mstServeStdioOptions: mcpStdio.ServeStdioOptions;

// MCP - Client
import * as mcpClient from "@modelcontextprotocol/client";
let mcClient: mcpClient.Client;
let mcInMemoryTransport: mcpClient.InMemoryTransport;
let mcTransport: mcpClient.Transport;
let mcListToolsResult: mcpClient.ListToolsResult;
let mcTool: mcpClient.Tool;
let mcCallToolResult: mcpClient.CallToolResult;

// MCP - Client stdio
import * as mcpClientStdio from "@modelcontextprotocol/client/stdio";
let mcsStdioClientTransport: mcpClientStdio.StdioClientTransport;
let mcsStdioServerParameters: mcpClientStdio.StdioServerParameters;

// Zod - tool input schemas
import * as Zod from "zod/v4";
let zodObject: Zod.ZodObject;
let zodString: Zod.ZodString;
