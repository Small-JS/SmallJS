CLASS IntersectionObserverEntry EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: IntersectionObserverEntry,
 a change in visibility reported by an IntersectionObserver."

METHODS

"Properties"

boundingClientRect
	"The Rect of the target, see: Element getBoundingClientRect."
	^ Rect fromJs: INLINE 'this.js.boundingClientRect'.
!
intersectionRatio
	"The visible ratio of the target, from 0 to 1."
	^ Float fromJs: INLINE 'this.js.intersectionRatio'.
!
intersectionRect
	"The Rect of the visible part of the target."
	^ Rect fromJs: INLINE 'this.js.intersectionRect'.
!
isIntersecting
	"True if the target intersects the root, also when the intersection has no area."
	^ Boolean fromJs: INLINE 'this.js.isIntersecting'.
!
rootBounds
	"The Rect of the root, including rootMargin. Nil for a target in a cross-origin iframe."
	^ Rect fromJs: INLINE 'this.js.rootBounds'.
!
target
	"The Element whose visibility changed."
	^ Element fromJsSubElement: INLINE 'this.js.target'.
!
time
	"The time of the change in milliseconds since the time origin, see: Event timeStamp."
	^ Float fromJs: INLINE 'this.js.time'.
!
