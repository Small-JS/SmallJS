CLASS VisualViewport EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: VisualViewport.
	 Note: Offsets and sizes are Floats, because they can be fractional when zoomed."

METHODS

"Offset."

offsetLeft
	^ Float fromJs: INLINE 'this.js.offsetLeft'.
!
offsetTop
	^ Float fromJs: INLINE 'this.js.offsetTop'.
!
offset
	^ self offsetLeft @ self offsetTop.
!

"Page."

pageLeft
	^ Float fromJs: INLINE 'this.js.pageLeft'.
!
pageTop
	^ Float fromJs: INLINE 'this.js.pageTop'.
!
pageOffset
	^ self pageLeft @ self pageTop.
!

"Size."

width
	^ Float fromJs: INLINE 'this.js.width'.
!
height
	^ Float fromJs: INLINE 'this.js.height'.
!
size
	^ self width @ self height.
!

"Scale."

scale
	^ Float fromJs: INLINE 'this.js.scale'.
!
