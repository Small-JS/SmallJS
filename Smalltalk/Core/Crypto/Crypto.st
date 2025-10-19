CLASS Crypto EXTENDS Object MODULE Crypto CLASSVARS '' VARS ''

"This class also implements Node.js module: crypto.subtle."

CLASSMETHODS

randomValues: typedArray
	INLINE 'crypto.getRandomValues( typedArray.js )'.
	^ typedArray.
!
randomUuid
	^ String fromJs: INLINE 'crypto.randomUUID()'.
!

"==== Subtle API ===="

"Encryption  / decryption"

encrypt: algorithm key: key data: data then: block error: errorBlock
	Error.	"force import"
	INLINE 'crypto.subtle.encrypt( algorithm.js, key.js, data.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
decrypt: algorithm key: key data: data then: block error: errorBlock
	INLINE 'crypto.subtle.decrypt( algorithm.js, key.js, data.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!

"Hashing"

digest: algorithm data: data then: block error: errorBlock
	INLINE 'crypto.subtle.digest( algorithm.js, data.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!

"Signing"

sign: algorithm key: key data: data then: block error: errorBlock
	INLINE 'crypto.subtle.sign( algorithm.js, key.js, data.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
verify: algorithm key: key signature: signature data: data then: block error: errorBlock
	INLINE 'crypto.subtle.verify( algorithm.js, key.js, signature.js, data.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!

"Keys"

generateKey: algorithm extractable: extractable usages: usages then: block error: errorBlock
	INLINE 'let algorithmPrefix = algorithm.js.name.substring( 0, 2 );
			let isKeyPairAlgorithm = [ "RS", "EC" ].includes( algorithmPrefix );
			let stKeyClass = isKeyPairAlgorithm ? stCryptoKeyPair$class : stCryptoKey$class;
			crypto.subtle.generateKey( algorithm.js, extractable.js, usages.$toJs() )
			.then( generatedKey => block.$value$( stKeyClass.$fromJs$( generatedKey ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
deriveKey: algorithm key: key type: type extractable: extractable usages: usages then: block error: errorBlock
	INLINE 'crypto.subtle.deriveKey( algorithm.js, key.js, type.js, extractable.js, usages.$toJs() )
			.then( derivedKey => block.$value$( stCryptoKey$class.$fromJs$( derivedKey ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
deriveBits: algorithm key: key length: length then: block error: errorBlock
	INLINE 'crypto.subtle.deriveBits( algorithm.js, key.js, length.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
exportKey: format key: key then: block error: errorBlock
	INLINE 'let stExportedKeyClass = format.js == "jwk" ? stJsObject$class : stArrayBuffer$class;
			crypto.subtle.exportKey( format.js, key.js )
			.then( exportedKey => block.$value$( stExportedKeyClass.$fromJs$( exportedKey ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
importKey: format keyData: keyData algorithm: algorithm extractable: extractable usages: usages then: block error: errorBlock
	INLINE 'crypto.subtle.importKey( format.js, keyData.js, algorithm.js, extractable.js, usages.$toJs() )
			.then( importedKey => block.$value$( stCryptoKey$class.$fromJs$( importedKey ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
wrapKey: format key: key wrappingKey: wrappingKey algorithm: algorithm then: block error: errorBlock
	INLINE 'crypto.subtle.wrapKey( format.js, key.js, wrappingKey.js, algorithm.js )
			.then( arrayBuffer => block.$value$( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
unwrapKey: format key: key unwrappingKey: unwrappingKey unwrapAlgo: unwrapAlgo
	algorithm: algorithm extractable: extractable usages: usages then: block error: errorBlock
	INLINE 'crypto.subtle.unwrapKey( format.js, key.js, unwrappingKey.js, unwrapAlgo.js, algorithm.js, extractable.js, usages.$toJs() )
			.then( unwrappedKey => block.$value$( stCryptoKey$class.$fromJs$( unwrappedKey ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
