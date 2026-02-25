// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
console.log("testmode:" + String( testMode ) );
if( testMode ) {
	let moduleName = "./TestBallsApp.js";
	import( moduleName )
		.then( module => { module.stTestBallsApp$class.$new().$start(); } );
} else {
	let moduleName = "./BallsApp.js";
	import( moduleName )
		.then( module => { module.stBallsApp$class.$new().$start(); } );
}

