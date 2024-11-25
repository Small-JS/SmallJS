CLASS PiBenchmark EXTENDS Benchmark MODULE Benchmark CLASSVARS '' VARS ''

"Implements JS and ST benchmark for calculating digits of PI."

INLINE 'import { Pi } from "./JavaScript/Pi.js";'

constructor
	"Number of digits to find."
	size := 20.
!
name
	^ 'Pi'.
!
runJs
	^ String fromJs: INLINE 'Pi.digits( this.size.js )'.
!
runSt
	| digits q r t i digit u |

	digits := ''.
	q := 1.
	r := 180.
	t := 60.
	i := 2.

	self size timesRepeat: [
		digit := i * 27 - 12 * q + ( r * 5 ) // ( t * 5 ).
		digits := digits, digit toString.

		u := i * 3.
		u := u + 1 * 3 * ( u + 2 ).
		r := i * 5 - 2 * q + r - ( t * digit ) * u * 10.
		q := i * 2 - 1 * q * 10 * i.
		t := t * u.
		i increment ].

	^ digits.
!
