CLASS MediaQueryListEvent EXTENDS Event MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS MediaQueryListEvent class.
 Sent to a MediaQueryList with type 'change', when the result of its media query changes."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new MediaQueryListEvent( type.js )'.
!
type: type options: options
	"Options is a MediaQueryListEventOptions instance."
	^ self fromJs: INLINE 'new MediaQueryListEvent( type.js, options.js )'.
!

METHODS

matches
	"True if the document now matches the media query."
	^ Boolean fromJs: INLINE 'this.js.matches'.
!
media
	"The serialized media query String."
	^ String fromJs: INLINE 'this.js.media'.
!
