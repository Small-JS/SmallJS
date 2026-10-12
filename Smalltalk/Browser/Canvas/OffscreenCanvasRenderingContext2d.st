CLASS OffscreenCanvasRenderingContext2d EXTENDS CanvasRenderingContext2d MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: OffscreenCanvasRenderingContext2D.
	 It has the same drawing API as CanvasRenderingContext2D,
	 except for the user interface methods that need a DOM element."

METHODS

"Properties"

canvas
	^ OffscreenCanvas fromJs: INLINE 'this.js.canvas'.
!
