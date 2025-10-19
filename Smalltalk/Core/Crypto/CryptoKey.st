CLASS CryptoKey EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

"This class is tested in class Crypto."

CLASSMETHODS

new
	self newEmpty.
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
	( name startsWith: 'RSA-' ) ifTrue: [ ^ RsaKeyGenParams fromJs: jsObject js ].
	( name startsWith: 'EC' ) ifTrue: [ ^ EcKeyGenParams fromJs: jsObject js ].

	self error: 'CryptoKey.algorithm: Unknown algorithm name: ', name.
!
usages
	^ Array fromJsStrings: INLINE 'this.js.usages'.
!
