CLASS File EXTENDS Blob MODULE DOM CLASSVARS '' VARS ''

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
