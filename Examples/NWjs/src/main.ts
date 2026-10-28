// Invoke the start method on a new MyNwApp ST object.

let gui = require( "nw.gui" );

function startApp()
{
	// If in test mode, invoke the start method on a new ST *test* app instance.
	// otherwise invoke the start method on a new ST app instance.

	let testMode = gui.App.argv.includes( '-test' );
	if( testMode ) {
		let moduleName = "./TestMyNwApp.js";
		import( moduleName )
			.then( module => module.stTestMyNwApp$class.$new().$start() )
			.catch( error => {
				// Close the window, otherwise the build script waits forever.
				console.error( error );
				gui.Window.get().close( true );
			} );
	} else {
		let moduleName = "./MyNwApp.js";
		import( moduleName )
			.then( module => { module.stMyNwApp$class.$new().$start(); } )
			.catch( error => { console.error( error ); } );
	}
}

// Start app after small delay to give the NW.js debugger in VSCode time to attach.
setTimeout( startApp, 500 );

