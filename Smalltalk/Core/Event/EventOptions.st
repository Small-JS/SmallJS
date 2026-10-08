CLASS EventOptions EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating an Event instance."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

bubbles
	^ Boolean fromJs: INLINE 'this.js.bubbles'.
!
bubbles: bubbles
	INLINE 'this.js.bubbles = bubbles.js'.
!
cancelable
	^ Boolean fromJs: INLINE 'this.js.cancelable'.
!
cancelable: cancelable
	INLINE 'this.js.cancelable = cancelable.js'.
!
composed
	^ Boolean fromJs: INLINE 'this.js.composed'.
!
composed: composed
	INLINE 'this.js.composed = composed.js'.
!
