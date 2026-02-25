// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestCounterUsingMithrilApp.js";
	import( moduleName )
		.then( module => { module.stTestCounterUsingMithrilApp$class.$new().$start(); } );
} else {
	let moduleName = "./CounterUsingMithrilApp.js";
	import( moduleName )
		.then( module => { module.stCounterUsingMithrilApp$class.$new().$start(); } );
}

