// Invoke the start method on a new CounterApp ST object.

let moduleName: string = "./Smalltalk/Counter.js";
import( moduleName )
	.then( module => { module.stCounterApp$class.$new().$start() } );
