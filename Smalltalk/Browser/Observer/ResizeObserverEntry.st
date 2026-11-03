CLASS ResizeObserverEntry EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: ResizeObserverEntry, a size reported by a ResizeObserver.
 The box sizes are Arrays of ResizeObserverSizes, currently with only one element."

METHODS

"Properties"

borderBoxSize
	^ Array fromJs: INLINE 'this.js.borderBoxSize' elementClass: ResizeObserverSize.
!
contentBoxSize
	^ Array fromJs: INLINE 'this.js.contentBoxSize' elementClass: ResizeObserverSize.
!
contentRect
	"The Rect of the content box, relative to the padding box. Prefer: contentBoxSize."
	^ Rect fromJs: INLINE 'this.js.contentRect'.
!
devicePixelContentBoxSize
	"The size in device pixels. Nil in browsers that do not support it, like Safari."
	^ Array fromJs: INLINE 'this.js.devicePixelContentBoxSize' elementClass: ResizeObserverSize.
!
target
	"The Element that was resized."
	^ Element fromJsSubElement: INLINE 'this.js.target'.
!
