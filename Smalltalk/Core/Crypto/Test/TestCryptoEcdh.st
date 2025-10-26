CLASS TestCryptoEcdh EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'algorithm keyPair'

"Tests the key exchange algorithm ECDH."

async testGenerateKey
	| params usages privateKey publicKey |

	algorithm := 'ECDH'.
	params := EcKeyGenParams new
		name: algorithm;
		namedCurve: 'P-384'.

	usages := #( 'deriveKey' 'deriveBits' ).
	keyPair := await Crypto generateKey: params extractable: true usages: usages.
	self assert: [ keyPair class = CryptoKeyPair ].

	privateKey := keyPair privateKey.
	self assert: [ privateKey class = CryptoKey ].
	self assert: [ privateKey type = 'private' ].
	self assert: [ privateKey extractable ].
	self assert: [ privateKey usages = usages ].
	self checkParams: privateKey algorithm.

	publicKey := keyPair publicKey.
	self assert: [ publicKey class = CryptoKey ].
	self assert: [ publicKey type = 'public' ].
	self assert: [ privateKey extractable ].
	self assert: [ publicKey usages = #() ].
	self checkParams: publicKey algorithm.

	await self deriveKey.
!
checkParams: params
	self assert: [ params class = EcKeyGenParams ].
	self assert: [ params name = algorithm ].
	self assert: [ params namedCurve = 'P-384' ].
!
async deriveKey
	| params derivedKeyParams derivedKeyUsages derivedKey derivedBits |

	params := EcdhKeyDeriveParams new
		name: 'ECDH';
		public: keyPair publicKey.

	"Derive AES key."

	derivedKeyParams := AesKeyGenParams new
		name: 'AES-CBC';
		length: 256.

	derivedKeyUsages := #( 'encrypt' 'decrypt' ).
	derivedKey := await Crypto deriveKey: params key: keyPair privateKey
		type: derivedKeyParams extractable: true usages: derivedKeyUsages.
	self assert: [ derivedKey class = CryptoKey ].
	self assert: [ derivedKey type = 'secret' ].
	self assert: [ derivedKey extractable ].
	self assert: [ derivedKey usages = derivedKeyUsages ].

	derivedKeyParams := derivedKey algorithm.
	self assert: [ derivedKeyParams class = AesKeyGenParams ].
	self assert: [ derivedKeyParams name = 'AES-CBC' ].
	self assert: [ derivedKeyParams length = 256 ].

	"Derive bits."

	derivedBits := await Crypto deriveBits: params key: keyPair privateKey length: 256.
	self assert: [ derivedBits class = ArrayBuffer ].
	self assert: [ derivedBits byteLength = 32 ].
!
