CLASS TestEcKeyGenParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params |
	params := EcKeyGenParams new.
	self assert: [ params class = EcKeyGenParams ].

	params name: 'ECDH'.
	self assert: [ params name = 'ECDH' ].

	params name: 'ECDSA'.
	self assert: [ params name = 'ECDSA' ].

	params namedCurve: 'P-521'.
	self assert: [ params namedCurve = 'P-521' ].
!
