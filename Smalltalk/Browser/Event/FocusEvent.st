CLASS FocusEvent EXTENDS UiEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS FocusEvent class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new FocusEvent( type.js )'.
!
type: type options: options
	"Options is a FocusEventOptions instance."
	^ self fromJs: INLINE 'new FocusEvent( type.js, options.js )'.
!

METHODS

"Events"

relatedTarget
	"The secondary target of the event, or nil.
	 E.g. for a focus event: the element that lost focus, for a blur event: the element that gets focus."
	^ MouseEvent targetFromJs: INLINE 'this.js.relatedTarget'.
!
