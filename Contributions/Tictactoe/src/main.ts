// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestTictactoeApp.js";
	import( moduleName )
		.then( module => { module.stTestTictactoeApp$class.$new().$start(); } );
} else {
	let moduleName = "./TictactoeApp.js";
	import( moduleName )
		.then( module => { module.stTictactoeApp$class.$new().$start(); } );
}

