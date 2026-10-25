CLASS BlobCreateOptions EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a Blob instance."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

endings
	"'transparent' (default) or 'native'."
	^ String fromJs: INLINE 'this.js.endings'.
!
endings: endings
	INLINE 'this.js.endings = endings.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
