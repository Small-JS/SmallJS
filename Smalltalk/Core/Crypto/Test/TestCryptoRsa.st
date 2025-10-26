CLASS TestCryptoRsa EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'algorithm keyPair'

"Tests the RSA encryption algorithm RSA-OAEP."

async testGenerateKey
	| params privateKey publicKey |
	algorithm := 'RSA-OAEP'.
	params := RsaKeyGenParams new
		name: algorithm;
		modulusLength: 2048;
		publicExponent: ( Uint8Array from: #( 1 0 1 ) );
		hash: 'SHA-256'.

	keyPair := await Crypto generateKey: params extractable: true usages: #( 'encrypt' 'decrypt' ).
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

	await self encryptDecrypt.
!
checkParams: params
	self assert: [ params class = RsaKeyGenParams ].
	self assert: [ params name = algorithm ].
	self assert: [ params modulusLength = 2048 ].
	self assert: [ params publicExponent = ( Uint8Array from: #( 1 0 1 ) ) ].
!
async encryptDecrypt
	| plainText plainData encryptedBuffer decryptedBuffer decryptedData decryptedText |

	plainText := 'Hello, RSA-OAEP!'.
	plainData := Uint8Array encodeFromString: plainText.
	encryptedBuffer := await Crypto encrypt: algorithm key: keyPair publicKey data: plainData.

	decryptedBuffer := await Crypto decrypt: algorithm key: keyPair privateKey data: encryptedBuffer.
	decryptedData := Uint8Array buffer: decryptedBuffer.
	decryptedText := decryptedData decodeToString.
	self assert: [ decryptedText = plainText ].
!
