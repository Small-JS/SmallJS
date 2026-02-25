// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = process.argv.includes( '-test' );
if( testMode ) {
	let moduleName = "./TestMyElectronMain.js";
	import( moduleName )
		.then( module => { module.stTestMyElectronApp$class.$new().$start(); } );
} else {
	let moduleName = "./MyElectronMain.js";
	import( moduleName )
		.then( module => { module.stMyElectronApp$class.$new().$start(); } );
}
