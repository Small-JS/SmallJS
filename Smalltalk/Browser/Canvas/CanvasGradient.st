CLASS CanvasGradient EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"From MDN:
 The CanvasGradient interface represents an opaque object describing a gradient.
 It is returned by one of these methods from the class CanvasRenderingContext2D:
 createLinearGradient(), createConicGradient() or createRadialGradient().
 Note: createConicGradient() is not wrapped yet in CanvasRenderingContext2d."

addColorStop: offset color: color
	INLINE 'this.js.addColorStop( offset.js, color.js )'.
!
