// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestMyBrowserApp.js";
	import( moduleName )
		.then( module => { module.stTestMyBrowserApp$class.$new().$start(); } );
} else {
	let moduleName = "./MyBrowserApp.js";
	import( moduleName )
		.then( module => { module.stMyBrowserApp$class.$new().$start(); } );
}

