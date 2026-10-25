// Invoke the start method on a new MyNodeWorker ST object.

let nodeModuleName: string = "./TestNode.js";
import( nodeModuleName )
	.then( module => { module.stMyNodeWorker$class.$new().$start(); } );
