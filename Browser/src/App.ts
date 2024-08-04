// Invoke the start method on a new BrowserApp ST object.

let moduleName: string = "./Script/BrowserApp.js";
import( moduleName )
	.then( module => { module.stMyBrowserApp$class.$new().$start(); } );
