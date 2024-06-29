CLASS CanvasGradient EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"From MDN:
 The CanvasGradient interface represents an opaque object describing a gradient.
 It is returned by one of these methods from the class CanvasRenderingContext2D:
 createLinearGradient(), createConicGradient() or createRadialGradient()"

addColorStop: offset color: color
	INLINE 'addColorStop( offset.js, color.js )'.
!
