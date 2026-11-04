CLASS TestBenchmarkApp EXTENDS Object MODULE TestBenchmarkApp CLASSVARS ''
	VARS 'benchmarkApp'

"Test BenchmarkApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	benchmarkApp := BenchmarkApp new start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestBenchmark all.
	await self testGui.

	"Wait shortly before closing, to allow a visual check of the results."
	await Timer timeout: 2000.
	self stop.
!
async testGui
	"Click the run all button and wait until all benchmarks have run.
	 Then check if all benchmark results are filled in."

	"Check if benchmarks are loaded in benchmark table."
	self assert: [ benchmarkApp resultsTable rows length - 1 = benchmarkApp benchmarks length ].

	"The button is disabled while the benchmarks run."
	benchmarkApp runAllButton click.
	self assert: [ benchmarkApp runAllButton disabled ].
	await [ benchmarkApp runAllButton disabled ] whileTrueAwait: async [
		await Timer timeout: 100 ].

	"Check if all benchmark results contain numbers."
	benchmarkApp resultsTable tBody rows do: [ :row |
		self assert: [ ( row cells at: 1 ) textContent toInteger >= 1000 ].
		self assert: [ ( row cells at: 2 ) textContent toInteger >= 0 ].
		self assert: [ ( row cells at: 3 ) textContent toInteger >= 0 ].
		self assert: [ ( row cells at: 4 ) textContent toFloat >= 0.0 ] ].
!
stop
	benchmarkApp stop.
!
