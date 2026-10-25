CLASS File EXTENDS Blob MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

fromArray: parts
	self error: 'A File needs a name, use fromArray:name:'.
!
fromArray: parts options: options
	self error: 'A File needs a name, use fromArray:name:options:'.
!
fromArray: parts name: name
	"Parts is an Array of Strings, typed arrays, ArrayBuffers or Blobs, or a single one of those."
	^ self fromJs: INLINE 'new File( this.$jsParts$( parts ), name.js )'.
!
fromArray: parts name: name options: options
	"Options is a FileCreateOptions instance."
	^ self fromJs: INLINE 'new File( this.$jsParts$( parts ), name.js, options.js )'.
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
