// Entry point for application.

let moduleName: string = "./ShopClient.js";
import( moduleName )
	.then( module => { module.stShopApp$class.$new().$start() } );
