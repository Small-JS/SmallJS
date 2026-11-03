CLASS TouchEventOptions EXTENDS UiEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a TouchEvent instance."

METHODS

"Touches"

changedTouches
	^ Array fromJs: INLINE 'this.js.changedTouches' elementClass: Touch.
!
changedTouches: changedTouches
	"An Array of Touches."
	INLINE 'this.js.changedTouches = changedTouches.$toJs()'.
!
targetTouches
	^ Array fromJs: INLINE 'this.js.targetTouches' elementClass: Touch.
!
targetTouches: targetTouches
	"An Array of Touches."
	INLINE 'this.js.targetTouches = targetTouches.$toJs()'.
!
touches
	^ Array fromJs: INLINE 'this.js.touches' elementClass: Touch.
!
touches: touches
	"An Array of Touches."
	INLINE 'this.js.touches = touches.$toJs()'.
!

"Modifier keys"

altKey
	^ Boolean fromJs: INLINE 'this.js.altKey'.
!
altKey: altKey
	INLINE 'this.js.altKey = altKey.js'.
!
ctrlKey
	^ Boolean fromJs: INLINE 'this.js.ctrlKey'.
!
ctrlKey: ctrlKey
	INLINE 'this.js.ctrlKey = ctrlKey.js'.
!
metaKey
	^ Boolean fromJs: INLINE 'this.js.metaKey'.
!
metaKey: metaKey
	INLINE 'this.js.metaKey = metaKey.js'.
!
shiftKey
	^ Boolean fromJs: INLINE 'this.js.shiftKey'.
!
shiftKey: shiftKey
	INLINE 'this.js.shiftKey = shiftKey.js'.
!
