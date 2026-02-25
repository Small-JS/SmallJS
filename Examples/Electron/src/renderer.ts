// This Renderer process runs in the browser.
// It does not have direct access to the Node.js Main context.
// IPC is used to bridge these contexts.

// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestMyElectronRenderer.js";
	import( moduleName )
		.then( module => { module.stTestMyElectronView$class.$new().$start(); } );
} else {
	let moduleName = "./MyElectronRenderer.js";
	import( moduleName )
		.then( module => { module.stMyElectronView$class.$new().$start(); } );
}

