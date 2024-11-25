export class Pi
{
	static digits( count: number ): string
	{
		let digits = '';

		let q = 1n;
		let r = 180n;
		let t = 60n;
		let i = 2n;

		while( count-- > 0 )
		{
			let digit = ( ( i * 27n - 12n ) * q + r * 5n ) / ( t * 5n );
			digits += digit.toString();

			let u = i * 3n;
			u = ( u + 1n ) * 3n * ( u + 2n );
			r = u * 10n * ( q * ( i * 5n - 2n ) + r - t * digit );
			q *= 10n * i * ( i++ * 2n - 1n );
			t *= u;
		}

		return digits;
	}
}
