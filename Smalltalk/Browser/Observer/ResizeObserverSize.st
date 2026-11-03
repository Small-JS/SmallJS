CLASS ResizeObserverSize EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: ResizeObserverSize, the size of a box in a ResizeObserverEntry.
 The sizes are logical: for horizontal text, inlineSize is the width and blockSize is the height."

METHODS

"Properties"

blockSize
	^ Float fromJs: INLINE 'this.js.blockSize'.
!
inlineSize
	^ Float fromJs: INLINE 'this.js.inlineSize'.
!
