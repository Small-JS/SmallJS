// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestTodoApp.js";
	import( moduleName )
		.then( module => { module.stTestTodoApp$class.$new().$start(); } );
} else {
	let moduleName = "./TodoApp.js";
	import( moduleName )
		.then( module => { module.stTodoApp$class.$new().$start(); } );
}
