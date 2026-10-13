CLASS StorageManager EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: StorageManager.
 It manages the storage of the site, like IndexedDB, Cache and localStorage.
 Get it with: Window default navigator storage."

CLASSMETHODS

default
	"Return the storage manager singleton."
	^ Window default navigator storage.
!

METHODS

async estimate
	"Return a StorageEstimate with the usage and quota of the site storage."
	^ StorageEstimate fromJs: INLINE 'await this.js.estimate()'.
!
async persist
	"Request permission to make the site storage persistent,
	 so it is not cleared by the browser under storage pressure.
	 Return true if the storage is persistent."
	^ Boolean fromJs: INLINE 'await this.js.persist()'.
!
async persisted
	"Return true if the site storage is persistent."
	^ Boolean fromJs: INLINE 'await this.js.persisted()'.
!
