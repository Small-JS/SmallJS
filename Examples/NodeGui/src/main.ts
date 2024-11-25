// Invoke the start method on an imported, new MyNodeGuiApp ST object.

let moduleName: string = "./MyNodeGuiApp.js";
import( moduleName )
	.then( module => { module.stMyNodeGuiApp$class.$new().$start(); } );
