// Entry point for application.

let moduleName: string = "./Smalltalk/ShopClient.js";
import( moduleName )
	.then( module => { module.stShopApp$class.$new().$start() } );
