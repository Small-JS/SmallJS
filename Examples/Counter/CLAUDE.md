This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is a minimal browser client app: a simple counter with DOM interaction (see `Counter.md`).
It uses the DOM API wrappers in the SmallJS library, located in the folder ../../Smalltalk/Browser.
For a more complex browser client app, see ../Todo.

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `CounterApp`, or `TestCounterApp` if the URL has `?test`.
- `Counter.st`: the model, holding the counter value.
- `CounterApp.st`: the main app (binds the HTML elements and updates the view).
- `Test/TestCounter.st`: unit tests for `Counter`.
- `Test/TestCounterApp.st`: runs the unit tests, then the GUI tests (clicks the buttons and checks the counter).
  Stops the app if all tests succeed.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3000
  Open http://localhost:3000/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css` and images.

## Goal

- Keep this example minimal. Make changes on specific requests only.
- Follow the structure and testing style of the other examples.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.
