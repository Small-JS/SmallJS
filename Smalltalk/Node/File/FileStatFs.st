CLASS FileStatFs EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Information about a mounted file system, returned by: Fs statfsSync:options: and Fsp statfs:options:.
 Sizes are in blocks of bsize bytes."

METHODS

type
	"Type of file system. 0 on Windows."
	^ Integer fromJs: INLINE 'this.js.type'.
!
bsize
	"Optimal transfer block size in bytes."
	^ Integer fromJs: INLINE 'this.js.bsize'.
!
frsize
	"Fragment size in bytes."
	^ Integer fromJs: INLINE 'this.js.frsize'.
!
blocks
	"Total data blocks."
	^ Integer fromJs: INLINE 'this.js.blocks'.
!
bfree
	"Free blocks."
	^ Integer fromJs: INLINE 'this.js.bfree'.
!
bavail
	"Free blocks available to unprivileged users."
	^ Integer fromJs: INLINE 'this.js.bavail'.
!
files
	"Total file nodes. 0 on Windows."
	^ Integer fromJs: INLINE 'this.js.files'.
!
ffree
	"Free file nodes. 0 on Windows."
	^ Integer fromJs: INLINE 'this.js.ffree'.
!
