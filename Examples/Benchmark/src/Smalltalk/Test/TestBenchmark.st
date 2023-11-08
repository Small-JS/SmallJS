CLASS TestBenchmark EXTENDS Test MODULE TestBenchmark CLASSVARS '' VARS ''

testPrimes
	| benchmark result |

	benchmark := PrimesBenchmark new size: 1000.
	result := 168.

	self assert: [ benchmark runJs = result ].
	self assert: [ benchmark runSt = result ].
!
testFibonacci
	| benchmark result |

	benchmark := FibonacciBenchmark new size: 50.
	result := 12586269025.

	self assert: [ benchmark runJs = result ].
	self assert: [ benchmark runSt = result ].
!
testPi
	| benchmark result |

	benchmark := PiBenchmark new size: 20.
	result := '31415926535897932384'.

	self assert: [ benchmark runJs = result ].
	self assert: [ benchmark runSt = result ].
!
