// Invoke the start method on a new BrowserApp ST object.

let moduleName: string = "./Playground.js";
import( moduleName )
	.then( module => { module.stPlaygroundApp$class.$new().$start(); } );
