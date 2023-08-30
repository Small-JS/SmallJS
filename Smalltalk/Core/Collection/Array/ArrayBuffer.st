CLASS ArrayBuffer EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

isView: buffer
	^ Boolean fromJs: INLINE 'ArrayBuffer.isView( buffer )'.
!

METHODS

"Properties"

byteLength
	^ Integer fromJs: INLINE 'this.js.byteLength'.
!

"Methods"

slice: from to: to
	^ ArrayBuffer fromJs: INLINE 'this.js.slice( from.js, to.js )'.
!
