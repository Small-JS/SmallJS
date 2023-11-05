// TS implementation of simple prime algorithm

export class Primes
{
    // Return the number of primes upto max.

    static primes( max: number ): number
    {
		let count = 0;

		for( let num = 2; num <= max; ++num )
			if( this.isPrime( num ) )
				++count;

		return count;
	}

	// Return true if num is prime.

	static isPrime( num: number ): boolean
	{
		if( num <= 3 )
			return num > 1;

		if( num % 2 == 0 || num % 3 == 0 )
			return false;

		let divider = 5.
		while( divider * divider <= num )
		{
			if( num % divider == 0 || num % ( divider + 2 ) == 0 )
				return false;

			divider += 6;
		}

		return true;
	}
}
