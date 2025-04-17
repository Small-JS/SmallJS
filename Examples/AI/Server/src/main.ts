// Invoke the start method on an imported, new AiServer ST object.

let moduleName: string = "./AiServer.js";
import( moduleName )
	.then( module => { module.stAiServer$class.$new().$start(); } );
