CLASS TestCryptoRsaSigning EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'plainText algorithm keyPair'

"Tests the RSA signing algorithm RSA-PSS."

test
	plainText := 'Hello, RSA-PSS!'.

	self generateKey.
!
generateKey
	| params |
	algorithm := 'RSA-PSS'.
	params := RsaKeyGenParams new
		name: algorithm;
		modulusLength: 2048;
		publicExponent: ( Uint8Array from: #( 1 0 1 ) );
		hash: 'SHA-256'.

	Crypto generateKey: params extractable: true usages: #( 'sign' 'verify' )
		then: [ :aKeyPair | self onGenerateKey: aKeyPair ]
		error: [ :error | error throw ].
!
onGenerateKey: aKeyPair
	| privateKey publicKey params |
	keyPair := aKeyPair.

	self assert: [ keyPair class = CryptoKeyPair ].

	privateKey := keyPair privateKey.
	self assert: [ privateKey class = CryptoKey ].
	self assert: [ privateKey type = 'private' ].
	self assert: [ privateKey extractable ].
	self assert: [ privateKey usages = #( 'sign' ) ].
	self checkParams: privateKey algorithm.

	publicKey := keyPair publicKey.
	self assert: [ publicKey class = CryptoKey ].
	self assert: [ publicKey type = 'public' ].
	self assert: [ publicKey usages = #( 'verify' ) ].
	self checkParams: publicKey algorithm.

	self sign.
!
checkParams: params
	self assert: [ params class = RsaKeyGenParams ].
	self assert: [ params name = algorithm ].
	self assert: [ params modulusLength = 2048 ].
	self assert: [ params publicExponent = ( Uint8Array from: #( 1 0 1 ) ) ].
!
sign
	| params plainData |
	params := RsaPssParams new saltLength: 32.
	plainData := Uint8Array encodeFromString: plainText.
	Crypto sign: params key: keyPair privateKey data: plainData
		then: [ :signatureBuffer | self verify: signatureBuffer params: params data: plainData ]
		error: [ :error | error throw ].
!
verify: signatureBuffer params: params data: plainData
	Crypto verify: params key: keyPair publicKey signature: signatureBuffer data: plainData
		then: [ :verified | self onVerify: verified ]
		error: [ :error | error throw ].
!
onVerify: verified
	self assert: [ verified ].
!
