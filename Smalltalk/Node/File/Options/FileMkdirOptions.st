CLASS FileMkdirOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

recursive
	^ Boolean fromJs: INLINE 'this.js.recursive'.
!
recursive: recursive
	INLINE 'this.js.recursive = recursive.js'.
!
mode
	^ Integer fromJs: INLINE 'this.js.mode'.
!
mode: mode
	INLINE 'this.js.mode = mode.js'.
!
