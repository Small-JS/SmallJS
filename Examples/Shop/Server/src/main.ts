// Invoke the start method on an imported, new ShopServer ST object.

let moduleName: string = "./ShopServer.js";
import( moduleName )
	.then( module => { module.stShopServer$class.$new().$start(); } );
