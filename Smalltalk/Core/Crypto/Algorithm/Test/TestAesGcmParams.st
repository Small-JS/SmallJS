CLASS TestAesGcmParams EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| params iv additionalData |
	params := AesGcmParams new.
	self assert: [ params class = AesGcmParams ].
	self assert: [ params name = 'AES-GCM' ].

	iv := Uint8Array new: 12.
	Crypto randomValues: iv.
	params iv: iv.
	self assert: [ params iv = iv ].

	additionalData := Uint8Array new: 8.
	params additionalData: additionalData.
	self assert: [ params additionalData = additionalData ].

	params tagLength: 64.
	self assert: [ params tagLength = 64 ].
!
