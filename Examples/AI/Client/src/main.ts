// Entry point for application.

let moduleName: string = "./AiClientApp.js";
import( moduleName )
	.then( module => { module.stAiClientApp$class.$new().$start() } );
