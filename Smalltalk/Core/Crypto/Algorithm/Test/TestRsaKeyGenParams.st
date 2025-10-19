CLASS TestRsaKeyGenParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params exponent |
	params := RsaKeyGenParams new.
	self assert: [ params class = RsaKeyGenParams ].

	params name: 'RSA-OAEP'.
	self assert: [ params name = 'RSA-OAEP' ].

	params modulusLength: 2048.
	self assert: [ params modulusLength = 2048 ].

	exponent := Uint8Array from: #( 1 0 1 ).
	params publicExponent: exponent.
	self assert: [ params publicExponent = exponent ].

	params hash: 'SHA-256'.
	self assert: [ params hash = 'SHA-256' ].
!
