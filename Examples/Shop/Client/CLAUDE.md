This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folder: ../.. (Examples).
The SmallJS standard library is located in the folder: ../../../Smalltalk.

This is the multi-page browser client of the Shop example: the skeleton of a web shop with users, products and orders.
It has separate HTML pages for login, products and orders, and gets its data from the Shop server's JSON web API.
It uses the DOM API wrappers in the SmallJS library, located in the folder ../../../Smalltalk/Browser.
Overview of the whole example: ../Shop.md. Client documentation: ./ShopClient.md.

The JS API documentation is here:
https://developer.mozilla.org/en-US/docs/Web/API

## Related projects

- `../Server`: Node.js server that serves the web files of this client and the JSON web API in route `/api`.
  It must be running to use or test this client.
- `../Shared`: ST classes shared by server and clients (`Person`, `Product`, `Order`, `LoginResponse`),
  module `ShopShared`, with their tests in `../Shared/Test`.
- `../ClientSpa`: the same client functionality, implemented as a Single Page Application (SPA).

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: entry point of `index.html`. Redirects to the login page, preserving the query string (e.g. `?test`).
- `loginMain.ts`, `productMain.ts`, `orderMain.ts`: entry points of the pages.
  Each starts its app (module `ShopClient`), or its test app (module `TestShopClient`) if the URL has `?test`.
- `include.ts`: replaces `<include src="...">` tags in HTML pages with the referenced HTML (used for the navigation bar).
- `App/ShopApp.st`: superclass of the page apps. `fetchApi:` fetches from the server API,
  shows errors in the page's `errorSpan`, and navigates to the login page on status 401 (not logged in).
- `App/LoginApp.st`: login page. On submit of the login form, POSTs the credentials as JSON body
  to `/api/login` (`LoginApp>>loginOptions:`; never put credentials in the URL)
  and navigates to the product page.
- `App/ProductApp.st`: product page. Shows the products from `/api/products` in a table.
- `App/OrderApp.st`: order page. Shows the orders from `/api/orders` in a table.
- `App/Test/TestLoginApp.st`: runs the unit tests of the imported Test* classes (from ../Shared/Test),
  checks the login fields and clicks the login button.
- `App/Test/TestProductApp.st`: checks the product table, then navigates to the order page.
- `App/Test/TestOrderApp.st`: checks the order table. This is the last test: it closes the window.
- The test apps are not subclasses of `Test`, so they are not run by `Test all` itself.
  Test mode is preserved across pages by `BrowserApp >> navigateTo:`.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t ../Shared src web/Script`;
  `-t` skips the library's Test folders, `+t` includes those of Shared and src),
  then starts the Shop server and runs the tests in the browsers configured in `.env` (see `.env.example`).
  Browsers close automatically if all tests succeed.
  Without `.env` here or in ../Server, the tests are skipped.
  It stops with an error if the server port is already in use.
- `./startServer.sh`: starts the Shop server (must be built and configured, see ../Server/ShopServer.md)
  with `SHOP_CLIENT="../Client/web"`, so this client is served at http://localhost:3000
  Open http://localhost:3000/?test to run the tests in the browser.
  The default login is user "John" with password "secret", already filled in.
- `./clean.sh`: removes the generated files.
- `../build.sh`, `../clean.sh`: do the same for server and both clients.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there;
  edit ./src, ../Shared or ../../../Smalltalk instead.
- The other files in `./web` are hand-written: `index.html`, `default.css`, images,
  and a folder per page with its HTML and CSS: `Login`, `Product`, `Order` and `NavBar` (included in other pages).

## Goal

- Keep this example simple. Make changes on specific requests only.
- Keep its functionality in line with ../ClientSpa.
- Follow the structure and testing style of the other examples.

## Coding style

- Follow the structure and coding style of the existing classes and of the other examples.
- Classes used by both server and clients belong in ../Shared, client-only classes in ./src.
- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like allowing popups or permission prompts.
- The GUI tests depend on the data in the database (see ../../../Database), e.g. 3 products and 2 orders for "John".

### Running tests (for Claude)

Do not use `./build.sh` to run the tests: it starts the Shop server and then kills port 3000.
Instead:

1. Compile if the sources changed:
   `tsc` and `../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t ../Shared src web/Script`
2. Check for a server on port 3000: `curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/`
   If none is running, start one in the background with `./startServer.sh`
   (requires a built server and ../Server/.env).
   If a server is running, make sure it serves this client (`SHOP_CLIENT="../Client/web"`), not ../ClientSpa.
   Never terminate the server after the run: it is left running for manual testing.
3. Run the tests only in headless Chrome, with a temporary profile folder outside this project:
   `timeout 60 "/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new --disable-gpu
   --user-data-dir=<temp folder> --enable-logging=stderr http://localhost:3000/?test`
   Do not write the profile or log files into this project folder.
4. Check the console output (lines containing `CONSOLE`):
   - `Successfully run sync tests: N` and `Successfully run async tests: N` report the unit tests.
   - Assertion errors report failures.
   - Chrome exits by itself (before the timeout) only if the GUI tests on all pages also pass,
     because the order page test closes the window after all assertions succeed.
5. After every test run, report the number of passed sync and async tests.
