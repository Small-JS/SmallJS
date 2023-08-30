
# SmallJS Browser test project

This project tests the browser (HTML / DOM) libraries of SmallJS.
First run `startWebBrowser.sh` to start a static web server.
When the app is started, all ST sources are compiled first.
Then all unit tests are run and tests can be done interactively in a browser. These browsers are supported: Chrome, Edge, Firefox. Select your preferred browser in the VSCode debug configuration.

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
