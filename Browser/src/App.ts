// Invoke the start method on a new BrowserApp ST object.

let browserAppModuleName: string = "./Smalltalk/BrowserApp.js";
import( browserAppModuleName )
	.then( module => { module.stBrowserApp$class.$new().$start(); } );
