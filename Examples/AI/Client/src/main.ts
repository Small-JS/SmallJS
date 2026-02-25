// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestAiClientApp.js";
	import( moduleName )
		.then( module => { module.stTestAiClientApp$class.$new().$start(); } );
} else {
	let moduleName = "./AiClientApp.js";
	import( moduleName )
		.then( module => { module.stAiClientApp$class.$new().$start(); } );
}

