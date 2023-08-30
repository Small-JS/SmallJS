CLASS DocumentType EXTENDS Node MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS abstract class: DocumentType."

METHODS

"Properties."

name
	^ String fromJs: INLINE 'this.js.name'.
!
publicId
	^ String fromJs: INLINE 'this.js.publicId'.
!
systemId
	^ String fromJs: INLINE 'this.js.systemId'.
!

"Methods."

after: node
	INLINE 'this.js.after( node.js )'.
!
before: node
	INLINE 'this.js.before( node.js )'.
!
replaceWith: node
	INLINE 'this.js.replaceWith( node.js )'.
!
