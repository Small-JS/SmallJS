CLASS Event EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS Event class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new Event( type.js )'.
!
fromJsSubEvent: jsEvent
	"Create ST Event subclass object from JS Event subclass object.
	 Defaults to Event."

	| jsClassName |

	INLINE 'if( jsEvent == null ) return stNil'.

	jsClassName := String fromJs: INLINE 'jsEvent.constructor.name'.
	jsClassName = 'UiEvent' ifTrue: [ ^ UiEvent fromJs: jsEvent ].
	jsClassName = 'MouseEvent' ifTrue: [ ^ MouseEvent fromJs: jsEvent ].
	jsClassName = 'PointerEvent' ifTrue: [ ^ PointerEvent fromJs: jsEvent ].

	^ self fromJs: jsEvent.
!

METHODS

"Properties."

bubbles
	^ Boolean fromJs: INLINE 'this.js.bubbles'.
!
cancelable
	^ Boolean fromJs: INLINE 'this.js.cancelable'.
!
composed
	^ Boolean fromJs: INLINE 'this.js.composed'.
!
currentTarget
	^ EventTarget fromJs: INLINE 'this.js.currentTarget'.
!
defaultPrevented
	^ Boolean fromJs: INLINE 'this.js.defaultPrevented'.
!
eventPhase
	^ Integer fromJs: INLINE 'this.js.eventPhase'.
!
isTrusted
	^ Boolean fromJs: INLINE 'this.js.isTrusted'.
!
target
	^ EventTarget fromJs: INLINE 'this.js.target'.
!
timeStamp
	^ Date fromJs: INLINE 'this.js.timeStamp'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!

"Methods."

composedPath
	^ Array fromJs: INLINE 'this.js.composedPath()' elementClass: EventTarget.
!
preventDefault
	INLINE 'this.js.preventDefault()'.
!
stopImmediatePropagation
	INLINE 'this.js.stopImmediatePropagation()'.
!
stopPropagation
	INLINE 'this.js.stopPropagation()'.
!
