// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestCounterApp.js";
	import( moduleName )
		.then( module => { module.stTestCounterApp$class.$new().$start(); } );
} else {
	let moduleName = "./CounterApp.js";
	import( moduleName )
		.then( module => { module.stCounterApp$class.$new().$start(); } );
}

