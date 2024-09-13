// This Renderer process runs in the browser.
// It does not have direct access to the Node.js Main context.
// IPC is used to bridge these contexts.

let moduleName: string = "./MyElectronRenderer.js";
import( moduleName )
	.then( module => { module.stMyElectronView$class.$new().$start(); } );
