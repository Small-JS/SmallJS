CLASS BenchmarkApp EXTENDS BrowserApp MODULE Benchmark CLASSVARS ''
	VARS 'benchmarks size resultsTable runAllButton'

start
	self initializeBenchmarks: self benchmarkConfigs.
	self bindElements.
	self clearBenchmarks.

	self testMode ifTrue: [
		^ TestBenchmarkApp new test: self ].
!
initializeBenchmarks: configs
	| benchmark |

	benchmarks := Array new.
	configs do: [ :benchmarkConfig |
		benchmark := ( benchmarkConfig at: 0 ) new.
		benchmark size: ( benchmarkConfig at: 1 ).
		benchmarks add: benchmark ].
!
benchmarkConfigs
	"Array of benchmark configurations, each containing benchmark class and size to run."
	^ #(
		#( PrimesBenchmark 50000 )
		#( FibonacciBenchmark 100000 )
		#( PiBenchmark 10000 )
	)
!
bindElements
	resultsTable := Document getElementById: 'resultsTable'.
	self assert: [ resultsTable class = HtmlTableElement ].

	runAllButton := Document getElementById: 'runAllButton'.
	self assert: [ runAllButton class = HtmlButtonElement ].
	runAllButton onClick: [ self runAllButtonClicked ].
!
clearBenchmarks
	"(Re)load benchmarkClasses into table and clear results."
	| row |
	resultsTable tBody innerHtml: ''.
	benchmarks do: [ :benchmark |
		row := resultsTable tBody insertRow: -1.
		row insertCell textContent: benchmark name.
		row insertCell textContent: benchmark size.
		3 timesRepeat: [ row insertCell ] ].
!
runAllButtonClicked
	self clearBenchmarks.
	self setCursor: 'wait'.
	"Wait 0.1 seconds before starting benchmarks
	 to give browser time to update the HTML first."
	Timer timeout: 100 then: [
		self runBenchmarks ].
!
setCursor: value
	Document default body style setProperty: 'cursor' value: value.
	runAllButton style setProperty: 'cursor' value: value.
	resultsTable style setProperty: 'cursor' value: value.
!
runBenchmarks
	| benchmark row |

	0 to: benchmarks length - 1 do: [ :index |
		"Pause shortly between benchmarks to allow async GUI updates."
		Timer timeout: 100 then: [
			benchmark := benchmarks at: index.
			row := resultsTable rows at: index + 1.
			self runBenchmark: benchmark row: row ] ].
!
runBenchmark: benchmark row: row
		benchmark timeRunJs.
		( row cells at: 2 ) textContent: benchmark jsTime toString.

		benchmark timeRunSt.
		( row cells at: 3 ) textContent: benchmark stTime toString.

		( row cells at: 4 ) textContent: ( benchmark factor toFixed: 1 ).

		"Restrore cursor after last benchmark."
		benchmark = benchmarks last ifTrue: [
			self setCursor: 'default' ].
!

"Accessing (used by tests)"

benchmarks
	^ benchmarks.
!
resultsTable
	^ resultsTable.
!
runAllButton
	^ runAllButton.
!
