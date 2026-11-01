// If in test mode, invoke the start method on a new ST *test* app instance.
// If in server mode, invoke the start method on a new ST MCP server instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = process.argv.includes( "-test" );
let serverMode = process.argv.includes( "-server" );
if( testMode ) {
	let moduleName = "./TestMyMcpApp.js";
	import( moduleName )
		.then( module => { module.stTestMyMcpApp$class.$new().$start(); } );
} else if( serverMode ) {
	let moduleName = "./MyMcpApp.js";
	import( moduleName )
		.then( module => { module.stMyMcpServer$class.$new().$start(); } );
} else {
	let moduleName = "./MyMcpApp.js";
	import( moduleName )
		.then( module => { module.stMyMcpApp$class.$new().$start(); } );
}
