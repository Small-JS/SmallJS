// Invoke the start method on a new BrowserApp ST object.

let moduleName: string = "./Smalltalk/BrowserApp.js";
import( moduleName )
	.then( module => { module.stBrowserApp$class.$new().$start(); } );
