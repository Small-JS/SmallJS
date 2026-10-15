CLASS File EXTENDS Blob MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

fromArray: array name: name
	^ self fromJs: INLINE 'new File( array.$toJs(), name.js )'.
!
fromArray: array name: name options: options
	"Options is a FileCreateOptions instance."
	^ self fromJs: INLINE 'new File( array.$toJs(), name.js, options.js )'.
!

METHODS

"Properties"

lastModified
	^ Integer fromJs: INLINE 'this.js.lastModified'.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
webkitRelativePath
	^ String fromJs: INLINE 'this.js.webkitRelativePath'.
!
