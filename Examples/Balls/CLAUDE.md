This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is a small browser client app: colored bouncing balls drawn on an HTML canvas (see `Balls.md`).
It uses the DOM and Canvas API wrappers in the SmallJS library, located in the folder ../../Smalltalk/Browser.
For a more complex browser client app, see ../Todo.

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API
Canvas API: https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `BallsApp`, or `TestBallsApp` if the URL has `?test`.
- `Ball.st`: the model, holding a ball's radius, position, speed and color, and moving / bouncing it within bounds.
- `BallsApp.st`: the main app (binds the HTML elements, creates the balls,
  moves them with a `Timer` and draws them on the canvas with a 2D context).
- `Test/TestBall.st`: unit tests for `Ball`.
- `Test/TestBallsApp.st`: runs the unit tests, then the GUI tests
  (sets the ball count, clicks the start and stop buttons and checks the app state).
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

### Running tests (for Claude)

Do not use `./build.sh` to run the tests: it starts and then kills the web server on port 3000.
Instead:

1. Compile if the sources changed:
   `tsc` and `../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Script`
2. Check for a web server on port 3000: `curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/`
   If none is running, start one in the background with `./startWebServer.sh`.
   Never terminate the web server after the run: it is left running for manual testing.
3. Run the tests only in headless Chrome, with a temporary profile folder outside this project:
   `timeout 30 "/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new --disable-gpu
   --user-data-dir=<temp folder> --enable-logging=stderr http://localhost:3000/?test`
   Do not write the profile or log files into this project folder.
4. Check the console output (lines containing `CONSOLE`):
   - `Successfully run sync tests: N` and `Successfully run async tests: N` report the unit tests.
   - Assertion errors report failures.
   - Chrome exits by itself (before the timeout) only if the GUI tests also pass,
     because the test app closes the window after all assertions succeed.
5. After every test run, report the number of passed sync and async tests.
