CLASS TestCryptoRsa EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'plainText algorithm keyPair'

"Tests the RSA encryption algorithm RSA-OAEP."

test
	plainText := 'Hello, RSA-OAEP!'.

	self generateKey.
!
generateKey
	| params |
	algorithm := 'RSA-OAEP'.
	params := RsaKeyGenParams new
		name: algorithm;
		modulusLength: 2048;
		publicExponent: ( Uint8Array from: #( 1 0 1 ) );
		hash: 'SHA-256'.

	Crypto generateKey: params extractable: true usages: #( 'encrypt' 'decrypt' )
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
	self assert: [ privateKey usages = #( 'decrypt' ) ].
	self checkParams: privateKey algorithm.

	publicKey := keyPair publicKey.
	self assert: [ publicKey class = CryptoKey ].
	self assert: [ publicKey type = 'public' ].
	self assert: [ privateKey extractable ].
	self assert: [ publicKey usages = #( 'encrypt' ) ].
	self checkParams: publicKey algorithm.

	self encrypt.
!
checkParams: params
	self assert: [ params class = RsaKeyGenParams ].
	self assert: [ params name = algorithm ].
	self assert: [ params modulusLength = 2048 ].
	self assert: [ params publicExponent = ( Uint8Array from: #( 1 0 1 ) ) ].
!
encrypt
	| plainData |
	plainData := Uint8Array encodeFromString: plainText.

	Crypto encrypt: algorithm key: keyPair publicKey data: plainData
		then: [ :cypherBuffer | self decrypt: cypherBuffer ]
		error: [ :error | error throw ].
!
decrypt: cypherBuffer
	Crypto decrypt: algorithm key: keyPair privateKey data: cypherBuffer
		then: [ :decryptedBuffer | self onDecrypt: decryptedBuffer ]
		error: [ :error | error throw ].
!
onDecrypt: decryptedBuffer
	| decryptedData decryptedText |
	decryptedData := Uint8Array buffer: decryptedBuffer.
	decryptedText := decryptedData decodeToString.
	self assert: [ decryptedText = plainText ].
!
