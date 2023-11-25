CLASS Benchmark EXTENDS Object MODULE Benchmark CLASSVARS '' VARS 'size jsTime stTime'

"Abstract base class for benchmark implementations.
 The following 3 methods should be overridden in subclasses."

name
	self subclassResponsibility.
!
runJs: size
	self subclassResponsibility.
!
runSt: size
	self subclassResponsibility.
!

"Size indicates the number of 'iterations' in the benchmark.
 For higher values is should take more time to complete the benchmark.
 E.g.: In the PrimesBenchmark, size is the number of primes that are calculated."

size
	^ size.
!
size: aSize
	size := aSize.
!

"Stored times of benchmarks that have run."

stTime
	^ stTime.
!
jsTime
	^ jsTime.
!
factor
	^ jsTime = 0 ifTrue: [ 0.0 ] ifFalse: [ stTime toFloat / jsTime ].
!

"Time the running ot JS and ST benchmarks."

timeRunJs
	^ jsTime := self time: [ self runJs ].
!
timeRunSt
	^ stTime := self time: [ self runSt ].
!

time: block
	| start end |

	start := Date new toMilliseconds.
	"self log: block value."
	block value.
	end := Date new toMilliseconds.

	^ end - start
!
