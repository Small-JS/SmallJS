CLASS RsaPssParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Return new instance with sensible defaults."
	^ self newEmpty
		name: 'RSA-PSS';
		saltLength: 32.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert: [ #( 'RSA-PSS' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
saltLength
	^ ArrayBuffer fromJs: INLINE 'this.js.saltLength'
!
saltLength: saltLength
	INLINE 'this.js.saltLength = saltLength.js'
!
