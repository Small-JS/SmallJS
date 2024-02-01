// Invoke the start method on a new CounterApp ST object.

let moduleName: string = "./Smalltalk/CounterApp.js";
import( moduleName )
	.then( module => { module.stCounterApp$class.$new().$start() } );
