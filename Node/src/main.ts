// Invoke the start method on a new NodeApp ST object.
// This project is always in "test mode".

let nodeAppModuleName: string = "./NodeApp.js";
import( nodeAppModuleName )
	.then( module => { module.stNodeApp$class.$new().$start(); } );

