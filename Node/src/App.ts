// Invoke the start method on a new NodeApp ST object.

let nodeAppModuleName: string = "./NodeApp.js";
import( nodeAppModuleName )
	.then( module => { module.stNodeApp$class.$new().$start(); } );

