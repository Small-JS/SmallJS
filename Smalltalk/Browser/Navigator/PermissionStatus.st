CLASS PermissionStatus EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: PermissionStatus.
 Get it with: Permissions query: name."

METHODS

"Properties"

name
	"Return the name of the permission queried."
	^ String fromJs: INLINE 'this.js.name'.
!
state
	"Return 'granted', 'denied' or 'prompt'."
	^ String fromJs: INLINE 'this.js.state'.
!

"Testing"

isGranted
	^ self state = 'granted'.
!
isDenied
	^ self state = 'denied'.
!
isPrompt
	^ self state = 'prompt'.
!

"Events"

onChange: block
	"Block is called with an Event when the state of the permission changes."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJs: jsEvent ) ].
	INLINE 'this.js.onchange = jsBlock.js'.
!
