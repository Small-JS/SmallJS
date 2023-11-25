CLASS TestBenchmarkApp EXTENDS Object MODULE TestBenchmark CLASSVARS '' VARS 'benchmarkApp'

"Test BenchmarkApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aBenchmarkApp
	benchmarkApp := aBenchmarkApp.

	"Refer to one test class in a module to force importing all classes of that module."
	TestBenchmark.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly.
	 Exit if all tests succeed."

	"Check if benchmarks are loaded in banchmark table."
	self assert: [ benchmarkApp resultsTable rows length - 1 = benchmarkApp benchmarks length ].

	benchmarkApp runAllButton click.
	Timer timeout: 10000 then: [
		self checkResults.
		Timer timeout: 2000 then: [
			benchmarkApp stop ] ].
!
checkResults
	"Check if all benchmark results contain numbers."

	benchmarkApp resultsTable tBody rows do: [ :row |
		self assert: [ ( row cells at: 1 ) textContent toInteger >= 1000 ].
		self assert: [ ( row cells at: 2 ) textContent toInteger >= 0 ].
		self assert: [ ( row cells at: 3 ) textContent toInteger >= 0 ].
		self assert: [ ( row cells at: 4 ) textContent toFloat >= 0.0 ] ].
!
