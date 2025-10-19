CLASS EcKeyGenParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Return new instance with sensible defaults."
	^ self newEmpty
		name: 'ECDH';
		namedCurve: 'P-384'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert: [ #( 'ECDH' 'ACDSA' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
namedCurve
	^ String fromJs: INLINE 'this.js.namedCurve'
!
namedCurve: namedCurve
	self assert: [ #( 'P-256' 'P-384' 'P-512' ) includes: namedCurve ].
	INLINE 'this.js.namedCurve = namedCurve.js'
!
