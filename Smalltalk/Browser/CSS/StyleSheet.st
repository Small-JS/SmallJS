CLASS StyleSheet EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''
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
	^ String fromJs: INLINE 'this.js.title'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
