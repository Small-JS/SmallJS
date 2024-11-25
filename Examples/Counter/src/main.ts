// Invoke the start method on a new CounterApp ST object.

let moduleName: string = "./CounterApp.js";
import( moduleName )
	.then( module => { module.stCounterApp$class.$new().$start() } );
