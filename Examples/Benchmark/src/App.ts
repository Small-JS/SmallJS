// Invoke the start method on a new BenchmarkBrowserApp ST object.

let moduleName: string = "./Smalltalk/Benchmark.js";
import( moduleName )
	.then( module => { module.stBenchmarkApp$class.$new().$start() } );

