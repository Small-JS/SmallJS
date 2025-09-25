CLASS PathObject EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Directory"

dir
	^ String fromJs: INLINE 'this.js.dir'.
!
dir: dir
	INLINE 'this.js.dir = dir.js'.
!
root
	^ String fromJs: INLINE 'this.js.root'.
!
root: root
	INLINE 'this.js.root = root.js'.
!

"File"

base
	^ String fromJs: INLINE 'this.js.base'.
!
base: base
	INLINE 'this.js.base = base.js'.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
ext
	^ String fromJs: INLINE 'this.js.ext'.
!
ext: ext
	INLINE 'this.js.ext = ext.js'.
!
