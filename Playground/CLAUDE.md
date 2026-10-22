This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../Examples, ../Browser, ../Node.
The SmallJS standard library is located in the folder: ../Smalltalk.

This is the Playground app: a web page where you can evaluate arbitrary SmallJS expressions
and see the results. Expressions are compiled and evaluated locally in the browser,
using a port of the SmallJS compiler that compiles to memory.
See `Playground.md` for a description of how it works.

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `PlaygroundApp`, or `TestPlaygroundApp` if the URL has `?test`.
- `PlaygroundApp.st`: the main app (binds the expression and result text areas and the evaluate button).
- `Playground.st`: evaluates an expression via the TS class `Evaluator` and returns the result or error to blocks.
- `Evaluator.ts`: wraps the expression in a temporary class `Evaluator` (method `evaluate`),
  compiles it to memory and runs it in a `<script type="module">` node on the page.
  It loads the compiled class info from `./CompiledClassesJson.js` to resolve class references.
- `Compiler/`: port of the SmallJS compiler (see below).
- `Test/TestPlaygroundApp.st`, `Test/TestPlayground.st`: tests for this app.

## Compiler port

- The leading sources of the compiler are in `../Compiler/src`.
  The files in `./src/Compiler` are copies with a few Playground-specific changes.
  Search for the string "Playground" in these sources to find the adjusted code.
- `src/Compiler/SourceNode.ts` is unique to the Playground: a limited implementation of the
  npm package `source-node` that only manages source trees and does not generate source maps.
- When the compiler changes, re-port it by overwriting the files with the same names
  and re-applying the Playground changes. Do this on specific requests only.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../Compiler/start.sh`),
  then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3000
  Open http://localhost:3000/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css`, `Logo.png`, `favicon.ico`.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.
- Unit tests must not add entries to the session history of the test page (e.g. `pushState`),
  because then the test page cannot close itself after the tests.
