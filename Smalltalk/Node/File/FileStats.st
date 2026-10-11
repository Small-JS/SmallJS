CLASS FileStats EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

new
	^ self newEmpty.
!

modeUser: user group: group all: all
	"Helper function to create mode number from argument parts."
	^ user * 8 + group * 8 + all.
!

METHODS

dev
	^ Integer fromJs: INLINE 'this.js.dev'.
!
ino
	^ Integer fromJs: INLINE 'this.js.ino'.
!
mode
	^ Integer fromJs: INLINE 'this.js.mode'.
!
nlink
	^ Integer fromJs: INLINE 'this.js.nlink'.
!
uid
	^ Integer fromJs: INLINE 'this.js.uid'.
!
gid
	^ Integer fromJs: INLINE 'this.js.gid'.
!
size
	^ Integer fromJs: INLINE 'this.js.size'.
!
blksize
	^ Integer fromJs: INLINE 'this.js.blksize'.
!

"Type"

isFile
	^ Boolean fromJs: INLINE 'this.js.isFile()'.
!
isDirectory
	^ Boolean fromJs: INLINE 'this.js.isDirectory()'.
!
isSymbolicLink
	"Only true for stats from: lstat."
	^ Boolean fromJs: INLINE 'this.js.isSymbolicLink()'.
!
isBlockDevice
	^ Boolean fromJs: INLINE 'this.js.isBlockDevice()'.
!
isCharacterDevice
	^ Boolean fromJs: INLINE 'this.js.isCharacterDevice()'.
!
isFifo
	^ Boolean fromJs: INLINE 'this.js.isFIFO()'.
!
isSocket
	^ Boolean fromJs: INLINE 'this.js.isSocket()'.
!

"Times as milliseconds"

atimeMs
	^ Float fromJs: INLINE 'this.js.atimeMs'.
!
mtimeMs
	^ Float fromJs: INLINE 'this.js.mtimeMs'.
!
ctimeMs
	^ Float fromJs: INLINE 'this.js.ctimeMs'.
!

"Times as Dates"

atime
	^ Date fromJs: INLINE 'this.js.atime'.
!
mtime
	^ Date fromJs: INLINE 'this.js.mtime'.
!
ctime
	^ Date fromJs: INLINE 'this.js.ctime'.
!
