This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folder: ../../../Examples.
The SmallJS standard library is located in the folder: ../../../Smalltalk.

This is the AI MCP example app: an educational, self-contained Node.js app
implementing a simple MCP (Model Context Protocol) v2 server and host.
An MCP server exposes tools (and optionally resources and prompts)
that an AI client / LLM host can discover and call.
The host asks an LLM in Ollama a question, with the tools of the server,
and calls the tools on the server when the LLM asks for it. Ollama is required.
User documentation is in: MCP.md, with details in doc/Running.md and doc/Code.md.

Note: the project folder is named `MPC`, but the project, workspace (`MCP.code-workspace`) and docs use `MCP`.

## Current state

This project was copied from the RAG example (../RAG) and follows its structure (`.env`, Ollama in `build.sh`).
The server implements one tool, `get-forecast` (fake weather forecast for a `city`), served over stdio.
The MCP wrapper classes `McpServer`, `McpClient` and `McpTool` are in `src` (module `MyMcpApp`).

## Libraries

The app uses these SmallJS library folders:
- ../../../Smalltalk/Core: core classes.
- ../../../Smalltalk/Node: Node.js API wrappers, e.g. Environment, Fs, Process, Server (Express, Server).
- ../../../Smalltalk/AI/Shared: classes shared by AI server and client.
- ../../../Smalltalk/AI/Node: server-side AI classes; this app uses the Ollama subfolder
  (Ollama, OllamaChatRequest, OllamaMessage, OllamaTool, OllamaToolCall).
  Their unit tests (module `TestAi`) can't run in this project, because `TestAi` also imports the tests
  of the other AI providers, whose npm SDKs are not installed here. Run them in ../Server (`Test all`).

Related projects: ../Server (AI Server), ../Client (AI Client, browser app), ../RAG (RAG app).

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: entry point. With argument `-test` it starts `TestMyMcpApp`, with `-server` `MyMcpServer`,
  otherwise `MyMcpApp`.
- `MyMcpApp.st`: the MCP host. Starts `out/main.js -server` as a child process and connects an `McpClient` over stdio
  (`McpClient stdioTransportCommand:arguments:`), converts the MCP tools to `OllamaTool`s,
  then asks Ollama a question and loops: for each `OllamaToolCall` in the answer, call the tool on the MCP server
  and add the result as a message with role `tool`, until the answer has no tool calls.
- `MyMcpServer.st`: the MCP server with the tool `get-forecast`.
- Compiled ST classes are ES modules, exported as `st<ClassName>$class`;
  `main.ts` imports them dynamically and calls `$new().$start()`.
- Tests go in `src/Test`. `TestMyMcpApp` connects the app, checks the server's tool list,
  then asks Ollama for the forecast and checks that `get-forecast` was called and the answer includes 'sunny'.
  LLM answers vary: only check for words from the tool result.
- Tests do not catch errors (no `tryAwaitCatch:` to clean up and rethrow), so the app halts immediately
  on the first error, which makes debugging easier. Only catch errors a test expects.
- Async loops must be awaited, e.g. `await [ ... ] whileTrueAwait: async [ ... ]`:
  the compiler only adds `await` where it is written.
- In server mode, MCP JSON-RPC messages go over stdin/stdout, one per line.
  The server must never write anything else to stdout (e.g. `Console log:`); use stderr for logging.
- `types.ts`: imports npm modules only to inspect their TS types in VSCode; not used at runtime.

- npm modules are imported in `INLINE` statements of ST classes as complete namespaces,
  with the variable name ending in `$` to prevent name clashes with ST variables, e.g.
  `INLINE 'import * as mcpServer$ from "@modelcontextprotocol/server";'`,
  used as `new mcpServer$.McpServer( ... )`. Do not use named imports like `import { McpServer } ...`.
- A SmallJS method without an explicit `^` return answers `self`, e.g. `JsObject atJsProperty:put:`.
  So `JsObject newEmpty atJsProperty: 'city' put: 'Amsterdam'` already answers the JsObject: no `; yourself` needed.
- The compiler renames ST variables that are reserved JS names by appending `$` (e.g. `arguments` becomes `arguments$`),
  but not references to them in `INLINE` code. Do not use such names for variables referenced in `INLINE` code.

Library classes go in `../../../Smalltalk/AI/Node/...` or `../../../Smalltalk/Node/...`,
their tests in a `Test` subfolder: `Test/Test<Class>.st`.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t ../../../Smalltalk/AI/Shared ../../../Smalltalk/AI/Node src out`;
  `-t` skips `Test` folders of the following input folders, `+t` includes them again),
  then starts an Ollama server (log in `ollama.log`), loads `.env`,
  runs the tests with `node out/main.js -test` and terminates Ollama (port 11434).
  Without `.env` the tests are skipped.
- `./start.sh`: loads `.env` and runs the app without rebuilding. Ollama must be running.
- `./startOllama.sh`: starts a local Ollama server.
- VSCode launch configurations: `Launch App` and `Launch Test` (both load `.env`; Ollama must be running),
  and `Launch Server` (`-server`, interactive, stdin from the integrated terminal; no Ollama needed).
- `./install.sh`: installs npm dependencies. `./update.sh -y`: updates them.
- `./clean.sh`: removes the generated files.
- `.env` (see `.env.example`): `OLLAMA_BASE_URL` and `OLLAMA_MODELS` (chat model, must support tool calling,
  e.g. `qwen3.5:4b` (default) or `qwen3:4b`; `qwen:4b` does not). The model must be installed in Ollama.
  `.env` may contain secrets: never print, commit or copy `.env`.
- The parent folder scripts (`../build.sh`, `../clean.sh`, `../install.sh`, `../update.sh`) also call this project's scripts.

## Generated files

- `./out` contains compiled output (JS and source maps). Do not edit files there; edit ./src or ../../../Smalltalk instead.
- `package.json` has `"type": "module"`.

## Goal

- Implement and test a simple MCP v2 server and host, step by step, on specific requests only.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.
