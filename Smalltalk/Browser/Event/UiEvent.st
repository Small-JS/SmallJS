CLASS UiEvent EXTENDS Event MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS UIEvent class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new UIEvent( type.js )'.
!
type: type options: options
	"Options is a UiEventOptions instance."
	^ self fromJs: INLINE 'new UIEvent( type.js, options.js )'.
!
fromJsSubEvent: jsEvent
	"Create ST UiEvent subclass object from JS UIEvent subclass object.
	 Falls back to Event for other JS events."

	| jsClassName |

	INLINE 'if( jsEvent == null ) return stNil'.

	jsClassName := String fromJs: INLINE 'jsEvent.constructor.name'.
	jsClassName = 'UIEvent' ifTrue: [ ^ UiEvent fromJs: jsEvent ].
	jsClassName = 'MouseEvent' ifTrue: [ ^ MouseEvent fromJs: jsEvent ].
	jsClassName = 'PointerEvent' ifTrue: [ ^ PointerEvent fromJs: jsEvent ].

	^ Event fromJsSubEvent: jsEvent.
!

METHODS

detail
	"Event dependent detail. For click events: the current click count."
	^ Integer fromJs: INLINE 'this.js.detail'.
!
view
	"The Window that generated the event, or nil."
	^ Window fromJs: INLINE 'this.js.view'.
!
