// Invoke the start method on a new PharoClientApp ST object.

let moduleName: string = "./PharoClientApp.js";
import( moduleName )
	.then( module => { module.stPharoClientApp$class.$new().$start() } );
