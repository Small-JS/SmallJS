CLASS TestAesKeyGenParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params |
	params := AesKeyGenParams new.
	self assert: [ params class = AesKeyGenParams ].

	params name: 'AES-GCM'.
	self assert: [ params name = 'AES-GCM' ].

	params length: 256.
	self assert: [ params length = 256 ].
!
