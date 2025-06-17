// Invoke the start method on a new CounterUsingMithrilApp ST object.

let moduleName: string = "./CounterUsingMithrilApp.js";
import( moduleName )
	.then( module => { module.stCounterUsingMithrilApp$class.$new().$start() } );
