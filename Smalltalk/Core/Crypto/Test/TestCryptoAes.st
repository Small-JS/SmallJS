CLASS TestCryptoAes EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'plainText key keyUsages'

"Tests the AES encryption algorithm: AES-GCM"

test
	| params |
	plainText := 'Hello, AES-GCM!'.
	params := AesKeyGenParams new
		name: 'AES-GCM';
		length: 256.
	keyUsages := #( 'encrypt' 'decrypt' 'wrapKey' 'unwrapKey' ).
	Crypto generateKey: params extractable: true usages: keyUsages
		then: [ :generatedKey | self onGenerateKey: generatedKey ]
		error: [ :error | error throw ].
!
onGenerateKey: generatedKey
	self checkKey: generatedKey.
	key := generatedKey.
	self encrypt.
!
checkKey: key
	| params |
	self assert: [ key class = CryptoKey ].
	self assert: [ key type = 'secret' ].
	self assert: [ key extractable ].
	self assert: [ key usages = keyUsages ].

	params := key algorithm.
	self assert: [ params class = AesKeyGenParams ].
	self assert: [ params name = 'AES-GCM' ].
	self assert: [ params length = 256 ].
!
encrypt
	| params plainData |
	"params also contains the iv 12 byte nonce, needed for decrypting."
	params := AesGcmParams new.
	plainData := Uint8Array encodeFromString: plainText.
	Crypto encrypt: params key: key data: plainData
		then: [ :cypherBuffer | self decrypt: cypherBuffer params: params ]
		error: [ :error | error throw ].
!
decrypt: cypherBuffer params: params
	Crypto decrypt: params key: key data: cypherBuffer
		then: [ :decryptedBuffer | self onDecrypt: decryptedBuffer ]
		error: [ :error | error throw ].
!
onDecrypt: decryptedBuffer
	| decryptedData decryptedText |
	decryptedData := Uint8Array buffer: decryptedBuffer.
	decryptedText := decryptedData decodeToString.
	self assert: [ decryptedText = plainText ].

	self exportKeyRaw.
!
exportKeyRaw
	Crypto exportKey: 'raw' key: key
		then: [ :keyBuffer | self onExportKeyRaw: keyBuffer ]
		error: [ :error | error throw ].
!
onExportKeyRaw: keyBuffer
	self assert: [ keyBuffer class = ArrayBuffer ].
	self assert: [ keyBuffer byteLength = 32 ].

	self importKeyRaw: keyBuffer.
!
importKeyRaw: keyBuffer
	Crypto importKey: 'raw' keyData: keyBuffer algorithm: key algorithm extractable: true
		usages: keyUsages
		then: [ :importedKey | self onImportKeyRaw: importedKey ]
		error: [ :error | error throw ].
!
onImportKeyRaw: importedKey
	self checkKey: importedKey.
	self exportKeyJwk.
!
exportKeyJwk
	Crypto exportKey: 'jwk' key: key
		then: [ :jsonWebKey | self onExportKeyJwk: jsonWebKey ]
		error: [ :error | error throw ].
!
onExportKeyJwk: jsonWebKey
	self assert: [ jsonWebKey class = JsObject ].
	self assert: [ ( jsonWebKey atJsProperty: 'alg' ) = 'A256GCM' ].

	self importKeyJwk: jsonWebKey.
!
importKeyJwk: jsonWebKey
	Crypto importKey: 'jwk' keyData: jsonWebKey algorithm: key algorithm extractable: true usages: keyUsages
		then: [ :importedKey | self onImportKeyJwk: importedKey ]
		error: [ :error | error throw ].
!
onImportKeyJwk: importedKey
	self checkKey: importedKey.
	self wrapKey.
!
wrapKey
	| params |
	"params also has iv random bits that need to be used for unwrapping."
	params := AesGcmParams new.
	Crypto wrapKey: 'jwk' key: key wrappingKey: key algorithm: params
		then: [ :wrappedKey | self onWrapKey: wrappedKey params: params ]
		error: [ :error | error throw ].
!
onWrapKey: wrappedKey params: params
	self assert: [ wrappedKey class = ArrayBuffer ].
	self assert: [ wrappedKey byteLength = 160 ].

	self unwrapKey: wrappedKey params: params.
!
unwrapKey: wrappedKey params: params
	Crypto unwrapKey: 'jwk' key: wrappedKey unwrappingKey: key unwrapAlgo: params
		algorithm: key algorithm extractable: true usages: keyUsages
		then: [ :unwrappedKey | self onUnwrapKey: unwrappedKey ]
		error: [ :error | error throw ].
!
onUnwrapKey: unwrappedKey
	self checkKey: unwrappedKey.
!
