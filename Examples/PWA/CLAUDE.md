This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is a Progressive Web App (PWA): the card pairing game "memory", using emojis as card faces
(see `EmojiMemory.md`). It can be installed as a local app and runs offline.
It uses the DOM API wrappers in the SmallJS library, located in the folder ../../Smalltalk/Browser.

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API
For PWAs specifically:
https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps

## Source code

- All source code is in the folder: ./src
- `main.ts`: page entry point. Starts `EmojiMemoryApp`, or `TestEmojiMemoryApp` if the URL has `?test`.
- `Card.st`: a single card, holding its emoji face and whether it is turned face up.
- `Deck.st`: the game model, holding the cards in a grid of columns x rows.
  The card faces are fetched from `web/cards.json`.
- `EmojiMemoryApp.st`: the main app (binds the HTML elements, handles clicks and updates the view).
- `Test/TestCard.st`: unit tests for `Card`.
- `Test/TestDeck.st`: unit tests for `Deck`.
- `Test/TestEmojiMemoryApp.st`: runs the unit tests, then the GUI tests
  (starts games, clicks cards and checks the updates, including matching pairs and restarting a game).
  Stops the app if all tests succeed.

## PWA files

- `web/pwa.webmanifest`: the app manifest (name, icons, start URL, display mode).
- `web/ServiceWorker.js`: the service worker, registered in `index.html`.
  It caches the files listed in `cachedUrls` for offline use ("stale-while-revalidate").
  When adding or renaming files that the app needs offline, update `cachedUrls`
  and change `cacheName` to bust the cache.

## Build and run

The app is served on port **3010** (not 3000 like the other examples),
to prevent the PWA cache and the registered service worker from interfering with other websites.

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
- `./startWebServer.sh`: serves the folder `./web` at http://localhost:3010
  Open http://localhost:3010/?test to run the tests in the browser.
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css`, `cards.json`,
  `pwa.webmanifest`, `ServiceWorker.js` and images.

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

Do not use `./build.sh` to run the tests: it starts and then kills the web server on port 3010.
Instead:

1. Compile if the sources changed:
   `tsc` and `../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Script`
2. Check for a web server on port 3010: `curl -s -o /dev/null -w "%{http_code}" http://localhost:3010/`
   If none is running, start one in the background with `./startWebServer.sh`.
   Never terminate the web server after the run: it is left running for manual testing.
3. Run the tests only in headless Chrome, with a new temporary profile folder outside this project
   (a fresh profile also avoids stale files from the service worker cache):
   `timeout 60 "/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new --disable-gpu
   --user-data-dir=<temp folder> --enable-logging=stderr http://localhost:3010/?test`
   Do not write the profile or log files into this project folder.
   Keep the profile path short (e.g. a folder name of a few characters):
   Chrome nests the service worker storage deep inside the profile, and on Windows a path longer than
   260 characters makes service worker registration and CacheStorage fail with "Unexpected internal error".
4. Check the console output (lines containing `CONSOLE`):
   - `Successfully run sync tests: N` and `Successfully run async tests: N` report the unit tests.
   - Assertion errors report failures.
   - Chrome exits by itself (before the timeout) only if the GUI tests also pass,
     because the test app closes the window after all assertions succeed.
5. After every test run, report the number of passed sync and async tests.
