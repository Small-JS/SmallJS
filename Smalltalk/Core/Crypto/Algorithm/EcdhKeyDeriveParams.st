CLASS EcdhKeyDeriveParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Return new instance with sensible defaults."
	^ self newEmpty
		name: 'ECDH'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert: [ #( 'ECDH' 'X25519' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
public
	^ CryptoKey fromJs: INLINE 'this.js.public'
!
public: public1
	"Note: 'public' is a JS reserved keyword that gets renamed by the compiler."
	INLINE 'this.js.public = public1.js'
!
