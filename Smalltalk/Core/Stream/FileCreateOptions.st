CLASS FileCreateOptions EXTENDS BlobCreateOptions MODULE Core CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a File instance."

METHODS

lastModified
	^ Integer fromJs: INLINE 'this.js.lastModified'.
!
lastModified: lastModified
	INLINE 'this.js.lastModified = lastModified.js'.
!
