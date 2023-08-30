CLASS VisualViewport EXTENDS EventTarget MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS class: VisualViewport."

METHODS

"Offset."

offsetLeft
	^ Integer fromJs: INLINE 'this.js.offsetLeft'.
!
offsetTop
	^ Integer fromJs: INLINE 'this.js.offsetLeft'.
!
offset
	^ self offsetLeft @ self offsetTop.
!

"Page."

pageLeft
	^ Integer fromJs: INLINE 'this.js.pageLeft'.
!
pageTop
	^ Integer fromJs: INLINE 'this.js.pageLeft'.
!
pageOffset
	^ self pageLeft @ self pageTop.
!

"Size."

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
size
	^ self width @ self height.
!

"Scale."

scale
	^ Float fromJs: INLINE 'this.js.scale'.
!
