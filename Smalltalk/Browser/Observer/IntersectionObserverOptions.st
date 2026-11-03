CLASS IntersectionObserverOptions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating an IntersectionObserver instance."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

root
	^ Node fromJsSubNode: INLINE 'this.js.root'.
!
root: root
	"An Element or Document whose box is used as the viewport. Default: nil, the browser viewport."
	INLINE 'this.js.root = root.js'.
!
rootMargin
	^ String fromJs: INLINE 'this.js.rootMargin'.
!
rootMargin: rootMargin
	"A String like the CSS margin property, in px or %, e.g. '10px 20%'. Grows or shrinks the root box."
	INLINE 'this.js.rootMargin = rootMargin.js'.
!
threshold
	"A Float or an Array of Floats."
	( Boolean fromJs: INLINE 'Array.isArray( this.js.threshold )' ) ifTrue: [
		^ Array fromJs: INLINE 'this.js.threshold' elementClass: Float ].
	^ Float fromJs: INLINE 'this.js.threshold'.
!
threshold: threshold
	"A Float or an Array of Floats in the range 0-1:
	 the visible ratios of the target at which the block is called. Default: 0."
	INLINE 'this.js.threshold = threshold.$toJs()'.
!
