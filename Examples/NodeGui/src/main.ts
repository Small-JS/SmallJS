// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = process.argv.includes ( '-test' );
if( testMode ) {
	let moduleName = "./TestMyNodeGuiApp.js";
	import( moduleName )
		.then( module => { module.stTestMyNodeGuiApp$class.$new().$start(); } );
} else {
	let moduleName = "./MyNodeGuiApp.js";
	import( moduleName )
		.then( module => { module.stMyNodeGuiApp$class.$new().$start(); } );
}

