CLASS TouchEvent EXTENDS UiEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS TouchEvent class:
	 sent with types 'touchstart', 'touchmove', 'touchend' and 'touchcancel'
	 when touch points on a touch screen change. Each touch point is a Touch.
	 Desktop browsers without a touch screen may not have this class, see: available.
	 For handling mouse, pen and touch alike, prefer PointerEvent."

CLASSMETHODS

available
	"Answer true if the browser has the JS TouchEvent class."
	^ Boolean fromJs: INLINE 'typeof TouchEvent !== "undefined"'.
!
type: type
	^ self fromJs: INLINE 'new TouchEvent( type.js )'.
!
type: type options: options
	"Options is a TouchEventOptions instance."
	^ self fromJs: INLINE 'new TouchEvent( type.js, options.js )'.
!

METHODS

"Touches"

changedTouches
	"The Array of Touches that changed in this event,
	 e.g. for 'touchend' the touches that were removed."
	^ Array fromJs: INLINE 'this.js.changedTouches' elementClass: Touch.
!
targetTouches
	"The Array of Touches on the screen that started on the target of this event."
	^ Array fromJs: INLINE 'this.js.targetTouches' elementClass: Touch.
!
touches
	"The Array of all Touches on the screen."
	^ Array fromJs: INLINE 'this.js.touches' elementClass: Touch.
!

"Modifier keys"

altKey
	^ Boolean fromJs: INLINE 'this.js.altKey'.
!
ctrlKey
	^ Boolean fromJs: INLINE 'this.js.ctrlKey'.
!
metaKey
	^ Boolean fromJs: INLINE 'this.js.metaKey'.
!
shiftKey
	^ Boolean fromJs: INLINE 'this.js.shiftKey'.
!
