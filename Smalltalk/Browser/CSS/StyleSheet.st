CLASS StyleSheet EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class StyleSheet."

METHODS

"Properties."

disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
href
	^ String fromJs: INLINE 'this.js.href'.
!
media
	^ MediaList fromJs: INLINE 'this.js.media'.
!
ownerNode
	^ Node fromJsSubNode: INLINE 'this.js.ownerNode'.
!
title
	"Firefox returns null on missing title.
	 Convert it to empty string to match Chrome and Edge."
	^ String fromJs: INLINE 'this.js.title != null ? this.js.title : ""'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
