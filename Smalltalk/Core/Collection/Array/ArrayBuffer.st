CLASS ArrayBuffer EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new: byteLength
	^ self fromJs: INLINE 'new ArrayBuffer( byteLength.js )'.
!
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
