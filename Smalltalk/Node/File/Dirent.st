CLASS Dirent EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Names"

name
	^ String fromJs: INLINE 'this.js.name'.
!
parentPath
	^ String fromJs: INLINE 'this.js.parentPath'.
!

"Testing"

isFile
	^ Boolean fromJs: INLINE 'this.js.isFile()'.
!
isDirectory
	^ Boolean fromJs: INLINE 'this.js.isDirectory()'.
!
isBlockDevice
	^ Boolean fromJs: INLINE 'this.js.isBlockDevice()'.
!
isCharacterDevice
	^ Boolean fromJs: INLINE 'this.js.isCharacterDevice()'.
!
isSymbolicLink
	^ Boolean fromJs: INLINE 'this.js.isSymbolicLink()'.
!
isFifo
	^ Boolean fromJs: INLINE 'this.js.isFIFO()'.
!
isSocket
	^ Boolean fromJs: INLINE 'this.js.isSocket()'.
!

