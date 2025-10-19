CLASS AesGcmParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Return instance with sensible defaults."
	| iv |
	"12 byte nonce"
	iv := Uint8Array new: 12.
	Crypto randomValues: iv.

	^ self newEmpty
		name: 'AES-GCM';
		iv: iv.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert: [ #( 'AES-GCM' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
iv
	^ ArrayBuffer fromJs: INLINE 'this.js.iv'.
!
iv: iv
	INLINE 'this.js.iv = iv.js'
!
additionalData
	^ ArrayBuffer fromJs: INLINE 'this.js.additionalData'.
!
additionalData: additionalData
	INLINE 'this.js.additionalData = additionalData.js'.
!
tagLength
	^ ArrayBuffer fromJs: INLINE 'this.js.tagLength'.
!
tagLength: tagLength
	INLINE 'this.js.tagLength = tagLength.js'.
!
