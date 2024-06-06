CLASS StyleSheet EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class StyleSheet,
	 of which variable value contains an instance."

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
	 Convert it to emtpy string to match Chrome and Edge."
	^ String fromJs: INLINE 'this.js.title != null ? this.js.title : ""'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
