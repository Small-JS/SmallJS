CLASS Hash EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

"This class implements hash functions from the crypto framework."

INLINE 'import crypto from "crypto";'

CLASSMETHODS

create: algorithm
	^ self fromJs: INLINE 'crypto.createHash( algorithm.js )'.
!

METHODS

update: data
	INLINE 'this.js.update( data.js )'.
!
digest: encoding
	^ String fromJs: INLINE 'this.js.digest( encoding.js )'.
!
