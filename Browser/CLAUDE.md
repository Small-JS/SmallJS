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
