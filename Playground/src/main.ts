// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestPlaygroundApp.js";
	import( moduleName )
		.then( module => { module.stTestPlaygroundApp$class.$new().$start(); } );
} else {
	let moduleName = "./PlaygroundApp.js";
	import( moduleName )
		.then( module => { module.stPlaygroundApp$class.$new().$start(); } );
}

