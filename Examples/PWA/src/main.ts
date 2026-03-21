// If in test mode, invoke the start method on a new ST *test* app instance.
// otherwise invoke the start method on a new ST app instance.

let testMode = window.location.search.toLowerCase() == '?test';
if( testMode ) {
	let moduleName = "./TestEmojiMemoryApp.js";
	import( moduleName )
		.then( module => { module.stTestEmojiMemoryApp$class.$new().$start(); } );
} else {
	let moduleName = "./EmojiMemoryApp.js";
	import( moduleName )
		.then( module => { module.stEmojiMemoryApp$class.$new().$start(); } );
}

