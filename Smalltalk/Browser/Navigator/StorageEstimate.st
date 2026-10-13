CLASS StorageEstimate EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS object returned by: StorageManager estimate."

METHODS

quota
	"Return the number of bytes available to the site."
	^ Integer fromJs: INLINE 'this.js.quota'.
!
usage
	"Return the number of bytes used by the site."
	^ Integer fromJs: INLINE 'this.js.usage'.
!
