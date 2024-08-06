// Entry point for application.

let moduleName: string = "./Script/ShopClient.js";
import( moduleName )
	.then( module => { module.stShopApp$class.$new().$start() } );
