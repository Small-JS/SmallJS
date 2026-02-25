// If in test mode, invoke the start method on a new ST *test* server instance.
// otherwise invoke the start method on a new ST server instance.

let testMode = process.argv.includes( "-test" );
if( testMode ) {
	let moduleName = "./TestAiServer.js";
	import( moduleName )
		.then( module => { module.stTestAiServer$class.$new().$start(); } );
} else {
	let moduleName = "./AiServer.js";
	import( moduleName )
		.then( module => { module.stAiServer$class.$new().$start(); } );
}
