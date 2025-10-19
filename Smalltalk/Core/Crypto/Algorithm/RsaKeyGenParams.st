CLASS RsaKeyGenParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

"Implements JS interface: RsaHashedKeyGenParams"

CLASSMETHODS

new
	"Return new instance with sensible defaults."
	^ self newEmpty
		name: 'RSA-OAEP';
		modulusLength: 2048;
		publicExponent: ( Uint8Array from: #( 1 0 1 ) );
		hash: 'SHA-256'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert:[ #( 'RSASSA-PKCS1-v1_5' 'RSA-PSS' 'RSA-OAEP' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
modulusLength
	^ Integer fromJs: INLINE 'this.js.modulusLength'
!
modulusLength: modulusLength
	INLINE 'this.js.modulusLength = modulusLength.js'
!
publicExponent
	^ Uint8Array fromJs: INLINE 'this.js.publicExponent'
!
publicExponent: publicExponent
	INLINE 'this.js.publicExponent = publicExponent.js'
!
hash
	^ String fromJs: INLINE 'this.js.hash'
!
hash: hash
	self assert:[ #( 'SHA-256' 'SHA-384' 'SHA-512' ) includes: hash ].
	INLINE 'this.js.hash = hash.js'
!
