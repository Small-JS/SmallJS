
# Browser project

This project tests the browser (HTML / DOM) libraries of SmallJS.
First run `startWebBrowser.sh` to start a static web server.
When the app is started, all ST sources are compiled first.
Then all unit tests are run and tests can be done interactively in a browser.
These browsers are supported: Chrome, Edge, Firefox.
Select your preferred browser in the VSCode debug configuration.

Currently only common, standard HTML 5 features are supported.
If you want to add browser specific features use these methods to test which one is currently running:
`Window isChromium` (Chrome or Edge) or `Window isFirefox`

Front-end development is done in traditional MVC style:
Your app should acquire individual HTML elements from the current page and then manipulate them directly.
There is no intermediate HTML 'scripting' facility for accessing model variables from HTML like in Angular or React.
This was done for maximum customizability, speed and code clarity.
Of course you can first generate base HTML pages with any tool you like.

Application startup is done in `src/App.ts` (compiled to `web/App.js`).
It dynamically loads the compiled ST class `BrowserApp` from `web/Smalltalk/BrowserApp.js`
and calls its start method on a new instance.
You can set debug breakpoints on method calls in *.st files.

## Testing

Copy the file `.env.example` to `.env` and uncomment the browsers you want to run tests with
and possibly adjust their startup paths to match your OS and installation.

Test are started by running `test.sh`. This will first start the npm `http-server`.
Then start up enabled browsers with `localhost:3000./test.html` as the starting page.
After all tests have completed succesfuly, brouwsers should close automatically
If a browser stays open, check out what went wrong with [F12] dev tools.
Alternatively, for better debugging options, you can open `Browser.code-workspace` with VSCode,
select the test configuration for that browser, e.g. `Launch Chrome test`, and run the project with [F5] .

Note:\
Testing with a new browser will probably fail initially, because popups need to be allowed.\
Change this setting manually once for "localhost:3000" and then re-run tests.
