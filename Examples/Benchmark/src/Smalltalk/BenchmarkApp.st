CLASS BenchmarkApp EXTENDS Object MODULE Benchmark CLASSVARS ''
	VARS 'benchmarks size benchmarkTable runAllButton'

start
	self test.
	self initializeBenchmarks.
	self bindElements.
	self clearBenchmarks.
!
test
	"Refer to al least one test class from a module to import all its test classes automatically."
	TestBenchmark.
	"Run sync and async tests of all imported Test* classes."
	Test all.
!
initializeBenchmarks
	| benchmark |

	benchmarks := Array new.
	self benchmarkConfigs do: [ :benchmarkConfig |
		benchmark := ( benchmarkConfig at: 0 ) new.
		benchmark size: ( benchmarkConfig at: 1 ).
		benchmarks add: benchmark ].
!
benchmarkConfigs
	"Array of benchmark configurations, each containing benchmark class and size to run."
	^ #(
		#( PrimesBenchmark 100000 )
		#( FibonacciBenchmark 500000 )
		#( PiBenchmark 10000 )
	)
!
bindElements
	benchmarkTable := Document default getElementById: 'benchmarkTable'.
	self assert: [ benchmarkTable class = HtmlTableElement ].

	runAllButton := Document default getElementById: 'runAllButton'.
	self assert: [ runAllButton class = HtmlButtonElement ].
	runAllButton addEventListener: 'click' then: [ self runAllButtonClicked ].
!
clearBenchmarks
	"(Re)load benchmarkClasses into table and clear results."
	| row |
	benchmarkTable tBody innerHtml: ''.
	benchmarks do: [ :benchmark |
		row := benchmarkTable tBody insertRow: -1.
		row insertCell textContent: benchmark name.
		row insertCell textContent: benchmark size.
		3 timesRepeat: [ row insertCell ] ].
!
runAllButtonClicked
	self clearBenchmarks.
	self setCursor: 'wait'.

	"Wait 0.1 seconds before starting benchmarks
	 to give browser time to update the HTML first."
	Timer new timeout: 100 then: [
		self runBenchmarks ].
!
setCursor: value
	Document default body style setProperty: 'cursor' value: value.
	runAllButton style setProperty: 'cursor' value: value.
	benchmarkTable style setProperty: 'cursor' value: value.
!
runBenchmarks
	| benchmark row |

	0 to: benchmarks length - 1 do: [ :index |
		"Pause shortly between benchmarks to allow async GUI updates."
		Timer new timeout: 100 then: [
			benchmark := benchmarks at: index.
			row := benchmarkTable rows at: index + 1.
			self runBenchmark: benchmark row: row ] ].

	self setCursor: 'default'.
!
runBenchmark: benchmark row: row
		benchmark timeRunJs.
		( row cells at: 2 ) textContent: benchmark jsTime toString.

		benchmark timeRunSt.
		( row cells at: 3 ) textContent: benchmark stTime toString.

		( row cells at: 4 ) textContent: ( benchmark factor toFixed: 1 ).
!
