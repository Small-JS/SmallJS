CLASS CryptoKey EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

"This class is tested in the TestCrypto* classes."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

type
	^ String fromJs: INLINE 'this.js.type'.
!
extractable
	^ Boolean fromJs: INLINE 'this.js.extractable'.
!
algorithm
	| jsObject name |
	jsObject := JsObject fromJs: INLINE 'this.js.algorithm'.
	name := jsObject atJsProperty: 'name'.
	( name startsWith: 'AES-' ) ifTrue: [ ^ AesKeyGenParams fromJs: jsObject js ].
	"Also matches RSASSA-PKCS1-v1_5."
	( name startsWith: 'RSA' ) ifTrue: [ ^ RsaKeyGenParams fromJs: jsObject js ].
	( name startsWith: 'EC' ) ifTrue: [ ^ EcKeyGenParams fromJs: jsObject js ].

	"Other algorithms, e.g. HMAC, Ed25519, X25519."
	^ jsObject.
!
usages
	^ Array fromJsStrings: INLINE 'this.js.usages'.
!
