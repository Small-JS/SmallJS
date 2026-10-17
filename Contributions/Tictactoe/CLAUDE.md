This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This app implements the game of Tic-Tac-Toe (see `Tictactoe.md`).
A human player (X) plays against the computer (O) in a browser client app with DOM interaction.
It was created by converting the example app ../../Examples/Counter.
It uses the DOM API wrappers in the SmallJS library, located in the folder ../../Smalltalk/Browser.
For a more complex browser client app, see ../../Examples/Todo.

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `TictactoeApp`, or `TestTictactoeApp` if the URL has `?test`.
- `Tictactoe.st`: the model, holding the board, the winner and the game over state.
  The computer plays optimally, using minimax with alpha-beta pruning (`computerMoveFor:against:`).
- `TictactoeApp.st`: the main app (binds the HTML elements, builds the board table and updates the view).
- `Test/TestTictactoe.st`: unit tests for `Tictactoe`.
- `Test/TestTictactoeApp.st`: runs the unit tests, then the GUI tests (clicks the board cells and the New game button).
  Stops the app if all tests succeed.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3000
  A web server is usually already running on port 3000.
  Open http://localhost:3000/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css` and images.

## Goal

- Keep this app simple. Make changes on specific requests only.
- Follow the structure and testing style of the examples.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.
