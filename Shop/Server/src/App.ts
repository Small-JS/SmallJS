// Invoke the start method on a new NodeApp ST object.

let shopServerModuleName: string = "file://" + process.cwd()  + "/out/ShopServer.js";
import( shopServerModuleName )
	.then( module => { module.stShopServer$class.$new().$start(); } );
