CLASS TestRsaOaepParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params buffer |
	params := RsaOaepParams new.
	self assert: [ params class = RsaOaepParams ].
	self assert: [ params name = 'RSA-OAEP' ].

	buffer := ArrayBuffer new: 8.
	params label: buffer.
	self assert: [ params label = buffer ].
!
