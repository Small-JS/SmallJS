CLASS TestCryptoRsaSigning EXTENDS Test MODULE TestCrypto CLASSVARS ''
	VARS 'algorithm keyPair'

"Tests the RSA signing algorithm RSA-PSS."

async testGenerateKey
	| params privateKey publicKey |
	algorithm := 'RSA-PSS'.
	params := RsaKeyGenParams new
		name: algorithm;
		modulusLength: 2048;
		publicExponent: ( Uint8Array from: #( 1 0 1 ) );
		hash: 'SHA-256'.

	keyPair := await Crypto generateKey: params extractable: true usages: #( 'sign' 'verify' ).
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

	await self signVerify.
!
checkParams: params
	self assert: [ params class = RsaKeyGenParams ].
	self assert: [ params name = algorithm ].
	self assert: [ params modulusLength = 2048 ].
	self assert: [ params publicExponent = ( Uint8Array from: #( 1 0 1 ) ) ].
!
async signVerify
	| params plainText plainData signatureBuffer verified |

	params := RsaPssParams new saltLength: 32.
	plainText := 'Hello, RSA-PSS!'.
	plainData := Uint8Array encodeFromString: plainText.
	signatureBuffer := await Crypto sign: params key: keyPair privateKey data: plainData.

	verified := await Crypto verify: params key: keyPair publicKey signature: signatureBuffer data: plainData.
	self assert: [ verified ].
!
