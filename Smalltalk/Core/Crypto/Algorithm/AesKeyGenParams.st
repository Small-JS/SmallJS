CLASS AesKeyGenParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Return instance with sensible defaults."
	^ self newEmpty
		name: 'AES-CBC';
		length: 256.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert: [ #( 'AES-CBC' 'AES-CTR' 'AES-GCM' 'AES-KW' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
length
	^ Integer fromJs: INLINE 'this.js.length'
!
length: length
	INLINE 'this.js.length = length.js'
!
