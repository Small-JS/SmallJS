// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestWebWorkersApp.js";
	import( moduleName )
		.then( module => { module.stTestWebWorkersApp$class.$new().$start(); } );
} else {
	let moduleName = "./WebWorkersApp.js";
	import( moduleName )
		.then( module => { module.stWebWorkersApp$class.$new().$start(); } );
}

