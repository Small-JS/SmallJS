CLASS Hash EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"This class implements hash functions from the crypto framework."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as crypto$ from 'crypto';'"
INLINE 'const crypto$ = await import( "node:crypto" );'

CLASSMETHODS

create: algorithm
	^ self fromJs: INLINE 'crypto$.createHash( algorithm.js )'.
!

METHODS

update: data
	INLINE 'this.js.update( data.js )'.
!
digest: encoding
	^ String fromJs: INLINE 'this.js.digest( encoding.js )'.
!
