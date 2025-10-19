CLASS TestRsaPssParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params |
	params := RsaPssParams new.
	self assert: [ params class = RsaPssParams ].
	self assert: [ params name = 'RSA-PSS' ].

	params saltLength: 32.
	self assert: [ params saltLength = 32 ].
!
