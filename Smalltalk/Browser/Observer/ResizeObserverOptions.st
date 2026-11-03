CLASS ResizeObserverOptions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for: ResizeObserver observe:options:."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

box
	^ String fromJs: INLINE 'this.js.box'.
!
box: box
	"The box whose size changes are reported:
	 'content-box' (default), 'border-box' or 'device-pixel-content-box'."
	INLINE 'this.js.box = box.js'.
!
