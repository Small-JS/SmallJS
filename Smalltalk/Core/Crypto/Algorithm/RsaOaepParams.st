CLASS RsaOaepParams EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty
		name: 'RSA-OAEP'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	self assert: [ #( 'RSA-OAEP' ) includes: name ].
	INLINE 'this.js.name = name.js'.
!
label
	^ ArrayBuffer fromJs: INLINE 'this.js.label'
!
label: label
	INLINE 'this.js.label = label.js'
!
