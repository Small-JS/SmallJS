This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../Examples, ../Browser, ../Node.
The SmallJS standard library is located in the folder: ../Smalltalk.

This is an app testing the DOM API wrappers in the SmallJS library,
located in the folder ../Smalltalk/Browser.

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `MyBrowserApp`, or `TestMyBrowserApp` if the URL has `?test`.
- `MyBrowserApp.st`: the main app (loads the UI components and binds their elements).
- `Components/`, `InputComponents/`: UI components, each with tests in its own `Test/` folder.
- `worker.ts`, `sharedWorker.ts`: worker scripts used by the library's Worker and SharedWorker tests.
- `canvasWorker.ts`: worker script for `OffscreenCanvasComponent`, runs `Components/MyCanvasWorker.st`.
- `types.ts`: imports npm modules only to inspect their TS types in VSCode; not used at runtime.
- `Test/TestMyBrowserApp.st`, `Test/TestMyWindow.st`: tests for this app.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../Compiler/start.sh`),
  then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3000
  Open http://localhost:3000/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css`, `MyObject.json`, images,
  and the HTML templates of the components in `Components/` and `InputComponents/`.

## Goal

- Implement and test more libraries, but on specific requests only.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.
  Test such APIs with a mock JS object instead (see `TestGeolocation`, `TestHistory`).
- Unit tests must not add entries to the session history of the test page (e.g. `pushState`),
  also not from an iframe, because then the test page cannot close itself after the tests.

### Running the tests (for Claude)

Always run the tests this way, not with `./build.sh`:
`./build.sh` does not report test results, and it terminates the web server.

1. Compile: `tsc && ../Compiler/start.sh ../Smalltalk/Core ../Smalltalk/Browser src web/Script`
2. Use the web server already running on port 3000 (check with `curl http://localhost:3000/`).
   If it is not running, start it yourself in the background with `./startWebServer.sh`.
   Never stop the web server; leave it running after the tests,
   enabling manual testing.
3. Run the tests in headless Chrome and read the results from the console log:
   ```bash
   "/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new \
     --user-data-dir="<scratchpad>/chrome-profile" --enable-logging=stderr --v=0 --no-first-run \
     "http://localhost:3000/?test" > "<scratchpad>/out.txt" 2>&1
   grep CONSOLE "<scratchpad>/out.txt"
   ```
   Use a separate `--user-data-dir` so the user's own Chrome session is not affected.
   Success looks like: `Successfully run sync tests: N`, `Successfully run async tests: N`,
   `Disabled test modules: 0`. Anything else (errors, failed asserts, a missing summary) is a failure.
