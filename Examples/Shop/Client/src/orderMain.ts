// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

{
	let testMode = window.location.search.toLowerCase() == '?test';
	if( testMode ) {
		let moduleName = "./TestShopClient.js";
		import( moduleName )
			.then( module => { module.stTestOrderApp$class.$new().$start(); } );
	} else {
		let moduleName = "./ShopClient.js";
		import( moduleName )
			.then( module => { module.stOrderApp$class.$new().$start(); } );
	}
}
