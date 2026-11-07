This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders: ../ (this Examples folder), ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is an example app testing the browser Web Workers API in SmallJS library,
that is located in the folder: ../../Smalltalk/Browser/Workers

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `WebWorkersApp`, or `TestWebWorkersApp` if the URL has `?test`.
- `worker.ts`: worker script entry point. Starts a new `MyWorker` instance inside the worker thread.
- `WebWorkersApp.st`: the main app (UI, starting workers, showing results).
- `MyWorker.st`: the code that runs inside a worker thread.
- `MyMessage.st`: the message object passed between the app and its workers.
- `Test/TestWebWorkersApp.st`: tests for this app.
- `types.ts`: declares variables of the Web Workers API TS types, only to inspect those types in VSCode.
  It is not used when running the app.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`)
  against the libraries `../../Smalltalk/Core` and `../../Smalltalk/Browser`, then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3000
  Open http://localhost:3000/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` (`index.html`, `default.css`, images) are hand-written.

## Goal

- Implement and test the Web Workers API in the SmallJS library (../../Smalltalk/Browser/Workers).
- The library has both dedicated workers (`Worker`, `DedicatedWorkerGlobalScope`)
  and shared workers (`SharedWorker`, `SharedWorkerGlobalScope`).
- This example app only uses dedicated workers.
  The library's own worker tests are in `../../Smalltalk/Browser/Workers/Test`, including the shared worker tests.
  Those run from the `../../Browser` project (shared worker script: `../../Browser/src/sharedWorker.ts`),
  not from this app.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.

### Running tests (for Claude)

Do not use `./build.sh` to run the tests: it starts and then kills the web server on port 3000.
Instead:

1. Compile if the sources changed:
   `tsc` and `../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Script`
2. Check for a web server on port 3000: `curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/`
   If none is running, start one in the background with `./startWebServer.sh`.
   Never terminate the web server after the run: it is left running for manual testing.
3. Run the tests only in headless Chrome, with a temporary profile folder outside this project:
   `timeout 60 "/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new --disable-gpu
   --user-data-dir=<temp folder> --enable-logging=stderr http://localhost:3000/?test`
   Do not write the profile or log files into this project folder.
4. Check the console output (lines containing `CONSOLE`):
   - `Successfully run sync tests: N` and `Successfully run async tests: N` report the unit tests.
   - Assertion errors report failures.
   - Chrome exits by itself (before the timeout) only if the GUI tests also pass,
     because the test app closes the window after all assertions succeed.
5. After every test run, report the number of passed sync and async tests.
