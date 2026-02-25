// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

// Note 1:
// Starting the ST app *after* onload is mandatory for the Pharo Zinc web server

// Note 2:
// Zinc gives an error when a URL query like '?test' is done at the root level of a website.
// To work around that, test mode is started with 'index.html?test.
// This bug is reported here: https://github.com/svenvc/zinc/issues/150"

let testMode = window.location.search.endsWith( '?test' );
if( testMode ) {
	console.log( "Test mode");
	let moduleName = "./TestPharoClientApp.js";
	import( moduleName )
		.then( module => { window.onload = module.stTestPharoClientApp$class.$new().$start(); } );
} else {
	console.log( "Normail mode");
	let moduleName = "./PharoClientApp.js";
	import( moduleName )
		.then( module => { window.onload = module.stPharoClientApp$class.$new().$start(); } );
}

