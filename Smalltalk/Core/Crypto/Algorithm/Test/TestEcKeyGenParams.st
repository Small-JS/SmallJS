CLASS TestEcKeyGenParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params |
	params := EcKeyGenParams new.
	self assert: [ params class = EcKeyGenParams ].

	params name: 'ECDH'.
	self assert: [ params name = 'ECDH' ].

	params namedCurve: 'P-512'.
	self assert: [ params namedCurve = 'P-512' ].
!
