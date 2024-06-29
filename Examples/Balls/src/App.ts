// Invoke the start method on a new BallApp ST object.

let moduleName: string = "./Smalltalk/BallsApp.js";
import( moduleName )
	.then( module => { module.stBallsApp$class.$new().$start() } );
