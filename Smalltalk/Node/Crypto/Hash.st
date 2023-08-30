CLASS Hash EXTENDS JsObject MODULE Node CLASSVARS '' VARS ''
	"This class implements the Express framework.
	 Variable 'js' will contain an instance of the express() application object (function)'."

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
