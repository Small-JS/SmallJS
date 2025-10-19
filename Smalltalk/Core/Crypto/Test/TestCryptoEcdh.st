CLASS TestCryptoEcdh EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'plainText algorithm keyPair'

"Tests the key exchange algorithm ECDH."

test
	plainText := 'Hello, ECDH!'.

	self generateKey.
!
generateKey
	| params |
	algorithm := 'ECDH'.
	params := EcKeyGenParams new
		name: algorithm;
		namedCurve: 'P-384'.

	Crypto generateKey: params extractable: true usages: #( 'deriveKey' 'deriveBits' )
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
	self assert: [ privateKey usages = #( 'deriveKey' 'deriveBits' ) ].
	self checkParams: privateKey algorithm.

	publicKey := keyPair publicKey.
	self assert: [ publicKey class = CryptoKey ].
	self assert: [ publicKey type = 'public' ].
	self assert: [ privateKey extractable ].
	self assert: [ publicKey usages = #() ].
	self checkParams: publicKey algorithm.

	self deriveKey.
!
checkParams: params
	self assert: [ params class = EcKeyGenParams ].
	self assert: [ params name = algorithm ].
	self assert: [ params namedCurve = 'P-384' ].
!
deriveKey
	| params aesParams |
	params := EcdhKeyDeriveParams new
		name: 'ECDH';
		public: keyPair publicKey.

	aesParams := AesKeyGenParams new
		name: 'AES-CBC';
		length: 256.

	Crypto deriveKey: params key: keyPair privateKey type: aesParams
		extractable: true usages: #( 'encrypt' 'decrypt' )
		then: [ :derivedKey | self onDeriveKey: derivedKey ]
		error: [ :error | error throw ].
!
onDeriveKey: derivedKey
	| params |
	self assert: [ derivedKey class = CryptoKey ].
	self assert: [ derivedKey type = 'secret' ].
	self assert: [ derivedKey extractable ].
	self assert: [ derivedKey usages = #( 'encrypt' 'decrypt' ) ].

	params := derivedKey algorithm.
	self assert: [ params class = AesKeyGenParams ].
	self assert: [ params name = 'AES-CBC' ].
	self assert: [ params length = 256 ].

	self deriveBits.
!
deriveBits
	| params |
	params := EcdhKeyDeriveParams new
		name: 'ECDH';
		public: keyPair publicKey.

	Crypto deriveBits: params key: keyPair privateKey length: 256
		then: [ :derivedBits | self onDeriveBits: derivedBits ]
		error: [ :error | error throw ].
!
onDeriveBits: derivedBits
	self assert: [ derivedBits class = ArrayBuffer ].
	self assert: [ derivedBits byteLength = 32 ].
!

