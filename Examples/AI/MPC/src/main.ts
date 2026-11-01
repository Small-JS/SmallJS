// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = process.argv.includes( "-test" );
if( testMode ) {
	let moduleName = "./TestMyMcpApp.js";
	import( moduleName )
		.then( module => { module.stTestMyMcpApp$class.$new().$start(); } );
} else {
	let moduleName = "./MyMcpApp.js";
	import( moduleName )
		.then( module => { module.stMyMcpApp$class.$new().$start(); } );
}
