// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestBenchmarkApp.js";
	import( moduleName )
		.then( module => { module.stTestBenchmarkApp$class.$new().$start(); } );
} else {
	let moduleName = "./BenchmarkApp.js";
	import( moduleName )
		.then( module => { module.stBenchmarkApp$class.$new().$start(); } );
}

