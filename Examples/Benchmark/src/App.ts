// Invoke the start method on a new BenchmarkBrowserApp ST object.

let moduleName: string = "./Script/Benchmark.js";
import( moduleName )
	.then( module => { module.stBenchmarkApp$class.$new().$start() } );

