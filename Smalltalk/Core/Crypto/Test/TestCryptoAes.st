CLASS TestCryptoAes EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'keyUsages key'

"Tests the AES encryption algorithm: AES-GCM"

async test
	await self generateKey.
	await self encryptDecrypt.
	await self exportImportKey.
	await self wrapUnwrapKey.
!
async generateKey
	| params |
	params := AesKeyGenParams new
		name: 'AES-GCM';
		length: 256.
	keyUsages := #( 'encrypt' 'decrypt' 'wrapKey' 'unwrapKey' ).
	key := await Crypto generateKey: params extractable: true usages: keyUsages.
	self checkKey: key.
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
async encryptDecrypt
	| params plainText plainData encryptedBuffer decryptedBuffer decryptedData decryptedText |

	"params also contains the 'iv' 12 byte nonce, needed for decrypting."
	params := AesGcmParams new.
	plainText := 'Hello, AES-GCM!'.
	plainData := Uint8Array encodeFromString: plainText.
	encryptedBuffer := await Crypto encrypt: params key: key data: plainData.

	decryptedBuffer := await Crypto decrypt: params key: key data: encryptedBuffer.
	decryptedData := Uint8Array buffer: decryptedBuffer.
	decryptedText := decryptedData decodeToString.
	self assert: [ decryptedText = plainText ].
!
async exportImportKey
	| exportedKey importedKey |

	"Export import in raw format."

	exportedKey := await Crypto exportKey: 'raw' key: key.
	self assert: [ exportedKey class = ArrayBuffer ].
	self assert: [ exportedKey byteLength = 32 ].

	importedKey := await Crypto importKey: 'raw' keyData: exportedKey
		algorithm: key algorithm extractable: true usages: keyUsages.
	self checkKey: importedKey.

	"Export import in jwk format."

	exportedKey := await Crypto exportKey: 'jwk' key: key.
	self assert: [ exportedKey class = JsObject ].
	self assert: [ ( exportedKey atJsProperty: 'alg' ) = 'A256GCM' ].

	importedKey := await Crypto importKey: 'jwk' keyData: exportedKey
		algorithm: key algorithm extractable: true usages: keyUsages.
	self checkKey: importedKey.
!
async wrapUnwrapKey
	| params wrappedKey unwrappedKey |

	"params also has iv random bits that need to be used for unwrapping."
	params := AesGcmParams new.
	wrappedKey := await Crypto wrapKey: 'jwk' key: key wrappingKey: key algorithm: params.
	self assert: [ wrappedKey class = ArrayBuffer ].
	self assert: [ wrappedKey byteLength = 160 ].

	unwrappedKey := await Crypto unwrapKey: 'jwk' key: wrappedKey unwrappingKey: key unwrapAlgo: params
		algorithm: key algorithm extractable: true usages: keyUsages.
	self checkKey: unwrappedKey.
!
