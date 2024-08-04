CLASS CanvasPattern EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"From MDN:
 The CanvasPattern interface represents an opaque object
 describing a pattern, based on an image, a canvas, or a video,
 created by the CanvasRenderingContext2D.createPattern() method."

setTransform: domMatrix
	INLINE 'setTransform( domMatrix )'
!
