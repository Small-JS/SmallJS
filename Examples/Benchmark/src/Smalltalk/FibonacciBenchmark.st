CLASS FibonacciBenchmark EXTENDS Benchmark MODULE Benchmark CLASSVARS '' VARS ''

"Implements JS and ST benchmark for calculating Fibonacci numbers."

INLINE 'import { Fibonacci } from "./JavaScript/Fibonacci.js";'

constructor
	"Number of Fibonacci numbers to find."
	size := 1000.
!
name
	^ 'Fibonacci'.
!
runJs
	^ BigInt fromJs: INLINE 'Fibonacci.fib( this.size.js )'.
!
runSt
	"Return the n-th fibonacci number indicated by size."
	| a b c |

	size = 0 ifTrue: [ ^ 0 ].

	a := 0.
	b := 1.

	size - 1 timesRepeat: [
		c := a + b.
		a := b.
		b := c ].

	^ b.
!
