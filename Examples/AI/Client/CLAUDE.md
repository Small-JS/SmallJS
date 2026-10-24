This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folder: ../../../Examples.
The SmallJS standard library is located in the folder: ../../../Smalltalk.

This is the AI Client example app: the browser side of a simple AI text chat app.
The user selects an AI provider and model, asks questions and sees the conversation.
The whole conversation is resent with every question, so the AI has the context.
It talks to the AI Server (../Server) via its web API: `/api/providers` and `/api/chat`.
The AI Server also serves the static web content of this app (./web), so there is no separate web server.
User documentation: AiClient.md, and for the server and its web API: ../Server/AiServer.md

The app uses these SmallJS library folders:
- ../../../Smalltalk/Core: core classes.
- ../../../Smalltalk/Browser: DOM API wrappers, e.g. Document, HtmlSelectElement, Fetch, Timer.
- ../../../Smalltalk/AI/Shared: classes shared by AI server and client:
  AiChatRequest, AiChatResponse, AiProviders.

Related projects: ../Server (AI Server, Node.js app), ../RAG (Retrieval Augmented Generation app).

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: page entry point. Starts `AiClientApp`, or `TestAiClientApp` if the URL has `?test`.
- `AiClientApp.st`: the main app (binds the page elements, loads the providers and sends chat requests).
- `Test/TestAiClientApp.st`: runs `TestAiProviders all` (library tests), then tests the GUI,
  including a real chat request. It is not a subclass of `Test`.

Library classes shared with the server go in `../../../Smalltalk/AI/Shared/`,
their tests in its `Test` subfolder: `Test/Test<Class>.st`.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t ../../../Smalltalk/AI/Shared src web/Script`;
  `-t` skips `Test` folders of the following input folders, `+t` includes them again),
  then starts the AI Server and runs the tests in the browsers configured in `.env` (see `.env.example`).
  Without `.env` here, or without `../Server/.env`, the tests are skipped.
  Browsers close automatically if all tests succeed.
- `./startServer.sh`: starts the AI Server (`../Server/start.sh`), which serves this app
  on the port `AI_SERVER_PORT` from `../Server/.env` (default http://localhost:3000).
  The server must be built first (`../Server/build.sh`).
  Open http://localhost:3000/?test to run the tests in the browser.
- `./startOllama.sh`: starts a local Ollama server.
- `./clean.sh`: removes the generated files.
- `../Server/.env` contains secret API keys: never print, commit or copy them.
- The chat test makes a real request to an AI provider, which may cost tokens.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css`, images.

## Goal

- Implement and test more AI client features, but on specific requests only.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.

### Running the tests (for Claude)

Always run the tests this way, not with `./build.sh`:
`./build.sh` does not report test results, and it terminates the server on port 3000.

1. Compile: `tsc && ../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t ../../../Smalltalk/AI/Shared src web/Script`
2. Use the AI Server already running on port 3000 (check with `curl http://localhost:3000/api/providers`).
   If it is not running, start it yourself in the background with `./startServer.sh`.
   Never stop the server; leave it running after the tests, enabling manual testing.
3. Run the tests in headless Chrome and read the results from the console log:
   ```bash
   "/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new \
     --user-data-dir="<scratchpad>/chrome-profile" --enable-logging=stderr --v=0 --no-first-run \
     "http://localhost:3000/?test" > "<scratchpad>/out.txt" 2>&1
   grep CONSOLE "<scratchpad>/out.txt"
   ```
   Use a separate `--user-data-dir` so the user's own Chrome session is not affected.
   Success looks like: `Successfully run sync tests: N`, `Successfully run async tests: N`,
   `Disabled test modules: 0`, and no errors or failed asserts from the GUI test afterwards.
   Anything else (errors, failed asserts, a missing summary) is a failure.
