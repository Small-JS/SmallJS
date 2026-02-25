// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestFrequenciesApp.js";
	import( moduleName )
		.then( module => { module.stTestFrequenciesApp$class.$new().$start(); } );
} else {
	let moduleName = "./FrequenciesApp.js";
	import( moduleName )
		.then( module => { module.stFrequenciesApp$class.$new().$start(); } );
}

