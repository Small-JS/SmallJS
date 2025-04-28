// Invoke the start method on a new PharoClientApp ST object.

// Note: Starting the ST app *after* onload is mandatory for the Pharo Zinc web server

let moduleName: string = "./PharoClientApp.js";
import( moduleName )
	.then( module => { window.onload = module.stPharoClientApp$class.$new().$start() } );
