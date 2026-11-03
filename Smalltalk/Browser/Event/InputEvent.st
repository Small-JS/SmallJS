CLASS InputEvent EXTENDS UiEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS InputEvent class:
	 sent with types 'beforeinput' and 'input' when an editable element changes."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new InputEvent( type.js )'.
!
type: type options: options
	"Options is an InputEventOptions instance."
	^ self fromJs: INLINE 'new InputEvent( type.js, options.js )'.
!

METHODS

"Properties"

data
	"The inserted text, or nil, e.g. when deleting or when the change has no text, like formatting."
	^ String fromJs: INLINE 'this.js.data'.
!
dataTransfer
	"The DataTransfer with the inserted content for pasting, dropping and rich text, or nil."
	^ DataTransfer fromJs: INLINE 'this.js.dataTransfer'.
!
inputType
	"The kind of change, e.g. 'insertText', 'deleteContentBackward', 'insertFromPaste', 'formatBold',
	 or an empty String."
	^ String fromJs: INLINE 'this.js.inputType'.
!
isComposing
	"True if the event is sent during composition, e.g. with an input method editor."
	^ Boolean fromJs: INLINE 'this.js.isComposing'.
!

"Methods"

targetRanges
	"The Array of StaticRanges, as AbstractRanges, that the change will affect.
	 Only for 'beforeinput', empty for 'input'."
	^ Array fromJs: INLINE 'this.js.getTargetRanges()' elementClass: AbstractRange.
!
