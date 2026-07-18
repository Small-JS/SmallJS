// If in test mode, invoke the start method on a new ST *test* server instance.
// otherwise invoke the start method on a new ST server instance.

let testMode = process.argv.includes( "-test" );
if( testMode ) {
	let moduleName = "./TestRagApp.js";
	import( moduleName )
		.then( module => { module.stTestRagApp$class.$new().$start(); } );
} else {
	let moduleName = "./RagApp.js";
	import( moduleName )
		.then( module => { module.stRagApp$class.$new().$start(); } );
}
