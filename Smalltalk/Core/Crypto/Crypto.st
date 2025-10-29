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

async encrypt: algorithm key: key data: data
	Error.	"force import"
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.encrypt( algorithm.js, key.js, data.js )'.
!
async decrypt: algorithm key: key data: data
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.decrypt( algorithm.js, key.js, data.js )'.
!

"Hashing"

async digest: algorithm data: data
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.digest( algorithm.js, data.js )'.
!

"Signing"

async sign: algorithm key: key data: data
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.sign( algorithm.js, key.js, data.js )'.
!
async verify: algorithm key: key signature: signature data: data
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.verify( algorithm.js, key.js, signature.js, data.js )'.
!

"Keys"

async generateKey: algorithm extractable: extractable usages: usages
	| algorithmPrefix isKeyPairAlgorithm keyClass |
	algorithmPrefix := algorithm name substring: 0 to: 2.
	isKeyPairAlgorithm := #( 'RS' 'EC' ) includes: algorithmPrefix.
	keyClass := isKeyPairAlgorithm ifTrue: [ CryptoKeyPair] ifFalse: [ CryptoKey ].
	^ keyClass fromJs:
		INLINE 'await crypto.subtle.generateKey( algorithm.js, extractable.js, usages.$toJs() )'.
!
async deriveKey: algorithm key: key type: type extractable: extractable usages: usages
	^ CryptoKey fromJs:
		INLINE 'await crypto.subtle.deriveKey( algorithm.js, key.js, type.js, extractable.js, usages.$toJs() )'.
!
async deriveBits: algorithm key: key length: length
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.deriveBits( algorithm.js, key.js, length.js )'.
!
async exportKey: format key: key
	| exportClass |
	exportClass := format = 'jwk' ifTrue: [ JsObject ] ifFalse: [ ArrayBuffer ].
	^ exportClass fromJs:
		INLINE 'await crypto.subtle.exportKey( format.js, key.js )'.
!
async importKey: format keyData: keyData algorithm: algorithm extractable: extractable usages: usages
	^ CryptoKey fromJs:
		INLINE 'await crypto.subtle.importKey( format.js, keyData.js, algorithm.js, extractable.js, usages.$toJs() )'.
!
async wrapKey: format key: key wrappingKey: wrappingKey algorithm: algorithm
	^ ArrayBuffer fromJs:
		INLINE 'await crypto.subtle.wrapKey( format.js, key.js, wrappingKey.js, algorithm.js )'.
!
async unwrapKey: format key: key unwrappingKey: unwrappingKey unwrapAlgo: unwrapAlgo
	algorithm: algorithm extractable: extractable usages: usages
	^ CryptoKey fromJs:
		INLINE 'await crypto.subtle.unwrapKey( format.js, key.js, unwrappingKey.js, unwrapAlgo.js, algorithm.js, extractable.js, usages.$toJs() )'.
!
