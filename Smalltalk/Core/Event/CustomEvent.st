CLASS CustomEvent EXTENDS Event MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS CustomEvent class:
	 an application defined event, carrying any data in its detail property."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new CustomEvent( type.js )'.
!
type: type options: options
	"Options is a CustomEventOptions instance."
	^ self fromJs: INLINE 'new CustomEvent( type.js, options.js )'.
!

METHODS

detail
	"The data passed when creating the event. Can be any JS value, or nil."
	^ JsObject fromJs: INLINE 'this.js.detail'.
!
