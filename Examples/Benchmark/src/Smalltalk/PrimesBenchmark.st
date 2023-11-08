CLASS PrimesBenchmark EXTENDS Benchmark MODULE Benchmark CLASSVARS '' VARS ''

"Implements JS and ST benchmark for calculating primes."

INLINE 'import { Primes } from "../Script/Primes.js";'

constructor
	"Number upto which to find all primes."
	size := 100000.
!
name
	^ 'Primes'.
!
runJs
	^ Integer fromJs: INLINE 'Primes.primes( this.size.js )'.
!
runSt
	| count |
	count := 0.

	1 to: size do: [ :num |
		num isPrime ifTrue: [
			count increment ] ].

	^ count.
!
