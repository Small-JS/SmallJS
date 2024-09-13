// A BrowserWindow's preload script runs in a context that has access to
// both the HTML DOM and a limited subset of Node.js and Electron APIs.

let moduleName: string = "./MyElectronPreload.js";
import( moduleName )
	.then( module => { module.stMyElectronApi$class.$new().$expose(); } );

