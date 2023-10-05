// Invoke the start method on an imported, new ShopServer ST object.

let shopServerModuleName: string = "./ShopServer.js";
import( shopServerModuleName )
	.then( module => { module.stShopServer$class.$new().$start(); } );
