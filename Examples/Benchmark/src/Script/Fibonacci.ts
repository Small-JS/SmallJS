// TS implementation of simple prime algorithm

export class Fibonacci
{
	// Return the n-th fibonacci number.

	static fib( n: number ): BigInt
	{
		if( n == 0 )
			return 0n;

		let a = 0n;
		let b = 1n;

		for( let i = 2; i <= n; i++ ) {
			let c = a + b;
			a = b;
			b = c;
		}

		return b;
	}

}
