// Invoke the start method on a new MyNwApp ST object.

function startApp()
{
	let moduleName: string = "./MyNwApp.js";
	import( moduleName )
		.then( module => { module.stMyNwApp$class.$new().$start() } );
}

// Start app after small delay to give the NW.js debugger in VSCode time to attach.
setTimeout( startApp, 500 );

