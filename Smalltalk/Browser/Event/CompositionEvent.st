CLASS CompositionEvent EXTENDS UiEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS CompositionEvent class:
	 sent with types 'compositionstart', 'compositionupdate' and 'compositionend'
	 while text is entered indirectly, e.g. with an input method editor for Chinese or Japanese."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new CompositionEvent( type.js )'.
!
type: type options: options
	"Options is a CompositionEventOptions instance."
	^ self fromJs: INLINE 'new CompositionEvent( type.js, options.js )'.
!

METHODS

"Properties"

data
	"The text composed so far. For 'compositionend', the final text."
	^ String fromJs: INLINE 'this.js.data'.
!
