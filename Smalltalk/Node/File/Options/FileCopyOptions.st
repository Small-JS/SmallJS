CLASS FileCopyOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

dereference
	^ Boolean fromJs: INLINE 'this.js.dereference'.
!
dereference: dereference
	INLINE 'this.js.dereference = dereference.js'.
!
errorOnExist
	^ Boolean fromJs: INLINE 'this.js.errorOnExist'.
!
errorOnExist: errorOnExist
	INLINE 'this.js.errorOnExist = errorOnExist.js'.
!
force
	^ Boolean fromJs: INLINE 'this.js.force'.
!
force: force
	INLINE 'this.js.force = force.js'.
!
mode
	^ Integer fromJs: INLINE 'this.js.mode'.
!
mode: mode
	INLINE 'this.js.mode = mode.js'.
!
preserveTimestamps
	^ Boolean fromJs: INLINE 'this.js.preserveTimestamps'.
!
preserveTimestamps: preserveTimestamps
	INLINE 'this.js.preserveTimestamps = preserveTimestamps.js'.
!
recursive
	^ Boolean fromJs: INLINE 'this.js.recursive'.
!
recursive: recursive
	INLINE 'this.js.recursive = recursive.js'.
!
verbatimSymlinks
	^ Boolean fromJs: INLINE 'this.js.verbatimSymlinks'.
!
verbatimSymlinks: verbatimSymlinks
	INLINE 'this.js.verbatimSymlinks = verbatimSymlinks.js'.
!
filter: block
	"Block should have 2 path arguments: src and dest,
	and return true of the file should be copied."
	INLINE 'this.js.filter = ( src, dest ) =>
		block.$value$value$( stString$class.$fromJs$( src ), stString$class.$fromJs$( dest ) ).js'.
!
