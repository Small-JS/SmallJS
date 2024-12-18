// Invoke the start method on a new NodeApp ST object.

let nodeModuleName: string = "./out/TestNode.js";
import( nodeModuleName )
	.then( module => { module.stMyWorker$class.$new().$start(); } );
