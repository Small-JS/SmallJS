// If in test mode, invoke the start method on a new ST *test* server instance.
// otherwise invoke the start method on a new ST server instance.

let testMode = process.argv.includes( "-test" );
if( testMode ) {
	let moduleName = "./TestShopServer.js";
	import( moduleName )
		.then( module => { module.stTestShopServer$class.$new().$start(); } );
} else {
	let moduleName = "./ShopServer.js";
	import( moduleName )
		.then( module => { module.stShopServer$class.$new().$start(); } );
}

