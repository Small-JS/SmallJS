This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../Browser, ../Node.
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

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3000
  Open http://localhost:3000/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` (`index.html`, `default.css`, images) are hand-written.

## Goal

- Implement and test the Web Workers API in the SmallJS library (../../Smalltalk/Browser/Workers),
  starting with dedicated workers.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.
