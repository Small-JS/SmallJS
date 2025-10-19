CLASS TestEcdhKeyDeriveParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params key |
	params := EcdhKeyDeriveParams new.
	self assert: [ params class = EcdhKeyDeriveParams ].

	params name: 'ECDH'.
	self assert: [ params name = 'ECDH' ].

	key = CryptoKey new.
	params public: key.
	self assert: [ params public = key ].
!
