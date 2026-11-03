CLASS ResizeObserver EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: ResizeObserver,
 which reports changes to the size of Elements.
 When an Element is observed, its current size is reported once, before the next rendering."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new ResizeObserver with: ResizeObserver new: [ :entries :observer | ... ]'.
!
new: block
	"Block is called with an Array of ResizeObserverEntries and the ResizeObserver.
	 The second block argument is optional."
	| jsBlock |
	jsBlock := [ :jsEntries :jsObserver |
		block
			value: ( Array fromJs: jsEntries elementClass: ResizeObserverEntry )
			value: ( ResizeObserver fromJs: jsObserver ) ].
	^ self fromJs: INLINE 'new ResizeObserver( jsBlock.js )'.
!

METHODS

"Observing"

observe: target
	"Target is an Element. Observes its content box."
	INLINE 'this.js.observe( target.js )'.
!
observe: target options: options
	"Options is a ResizeObserverOptions instance."
	INLINE 'this.js.observe( target.js, options.js )'.
!
unobserve: target
	INLINE 'this.js.unobserve( target.js )'.
!
disconnect
	"Stop observing all targets."
	INLINE 'this.js.disconnect()'.
!
