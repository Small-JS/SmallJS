CLASS IntersectionObserver EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: IntersectionObserver,
 which reports changes in the visibility of Elements within a root Element or the viewport.
 When an Element is observed, its current intersection is reported once."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new IntersectionObserver with: IntersectionObserver new: [ :entries :observer | ... ][options:]'.
!
new: block
	"Block is called with an Array of IntersectionObserverEntries and the IntersectionObserver.
	 The second block argument is optional. The root is the viewport."
	^ self new: block options: IntersectionObserverOptions new.
!
new: block options: options
	"Options is an IntersectionObserverOptions instance.
	 Throws a JS DOMException named 'SyntaxError' if rootMargin is invalid,
	 or a JS RangeError if a threshold is not in the range 0-1."
	| jsBlock |
	jsBlock := [ :jsEntries :jsObserver |
		block
			value: ( Array fromJs: jsEntries elementClass: IntersectionObserverEntry )
			value: ( IntersectionObserver fromJs: jsObserver ) ].
	^ self fromJs: INLINE 'new IntersectionObserver( jsBlock.js, options.js )'.
!

METHODS

"Properties"

root
	"The root Element or Document, or nil for the viewport."
	^ Node fromJsSubNode: INLINE 'this.js.root'.
!
rootMargin
	"The normalized margin String, e.g. '10px 0px 10px 0px'."
	^ String fromJs: INLINE 'this.js.rootMargin'.
!
thresholds
	"The sorted Array of threshold Floats."
	^ Array fromJs: INLINE 'this.js.thresholds' elementClass: Float.
!

"Observing"

observe: target
	"Target is an Element. To be reported as intersecting, it must be a descendant of the root."
	INLINE 'this.js.observe( target.js )'.
!
unobserve: target
	INLINE 'this.js.unobserve( target.js )'.
!
disconnect
	"Stop observing all targets."
	INLINE 'this.js.disconnect()'.
!
takeRecords
	"Answer and remove the pending IntersectionObserverEntries, that are not yet passed to the block."
	^ Array fromJs: INLINE 'this.js.takeRecords()' elementClass: IntersectionObserverEntry.
!
