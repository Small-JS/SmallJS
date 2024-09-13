// Invoke the start method on an imported, new ShopServer ST object.

// import { MyElectronApp } from './MyElectronApp.js';
// new MyElectronApp().start();

let moduleName: string = "./MyElectronMain.js";
import( moduleName )
	.then( module => { module.stMyElectronApp$class.$new().$start(); } );

