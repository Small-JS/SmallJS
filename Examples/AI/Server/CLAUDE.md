This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folder: ../../../Examples.
The SmallJS standard library is located in the folder: ../../../Smalltalk.

This is the AI Server example app: the server side of a simple AI text chat app.
It serves the static web content of the AI Client (../Client/web)
and provides a web API that routes chat requests to multiple AI providers in a unified manner.
Supported providers: Ollama, OpenAI, Deepseek, Google AI and Anthropic.
User documentation, including the web API, is in: AiServer.md

The app uses these SmallJS library folders:
- ../../../Smalltalk/Core: core classes.
- ../../../Smalltalk/Node: Node.js API wrappers, e.g. Express, Environment, Fetch, Timer.
- ../../../Smalltalk/AI/Shared: classes shared by AI server and client:
  AiChatRequest, AiChatResponse, AiProviders.
- ../../../Smalltalk/AI/Node: server-side AI classes: Ai (base class), AiFactory,
  and per-provider wrappers of their npm modules in subfolders Anthropic, Deepseek, Googleai, Ollama, Openai.

Related projects: ../Client (AI Client, browser app), ../RAG (Retrieval Augmented Generation app).

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: entry point. With argument `-test` it starts `TestAiServer`, otherwise `AiServer`.
- `AiServer.st`: connects the AI providers available in `.env` and starts the Express web server
  with the routes `/api/providers` and `/api/chat`.
- `Test/TestAiServer.st`: starts the server, runs `Test all` (unit tests), then the web API tests,
  then stops the server. It is not a subclass of `Test`.
  It references each Test* class to force importing its module.
  New test classes must be referenced there, or they will not run.
- `types.ts`: imports the AI npm modules only to inspect their TS types in VSCode; not used at runtime.

Library classes go in `../../../Smalltalk/AI/Node/<Provider>/` (server only)
or `../../../Smalltalk/AI/Shared/` (also used by the client),
their tests in a `Test` subfolder: `Test/Test<Class>.st`.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t ../../../Smalltalk/AI/Shared ../../../Smalltalk/AI/Node src out`;
  `-t` skips `Test` folders of the following input folders, `+t` includes them again),
  then loads `.env` and runs the tests with `node out/main.js -test`.
  Without `.env` the tests are skipped.
- `./start.sh`: loads `.env` and starts the server (not in test mode) without rebuilding.
- `./startOllama.sh`: starts a local Ollama server.
- `./install.sh`: installs npm dependencies. `./update.sh -y`: updates them.
- `./clean.sh`: removes the generated files.
- `.env` (see `.env.example`): server port (`AI_SERVER_PORT`) and per-provider settings:
  `<PROVIDER>_BASE_URL`, `<PROVIDER>_MODELS` and `<PROVIDER>_API_KEY`.
  A provider is only enabled when its variables are set. At least one provider must be available.
  `.env` contains secret API keys: never print, commit or copy them.
- The chat tests make real requests to every enabled provider, which may cost tokens.

## Generated files

- `./out` contains compiled output (JS and source maps). Do not edit files there; edit ./src or ../../../Smalltalk instead.
- `package.json` has `"type": "module"`: compiled ST classes are ES modules, exported as `st<ClassName>$class`.

## Goal

- Implement and test more AI features and providers, but on specific requests only.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.
