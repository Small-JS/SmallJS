CLASS KeyboardEvent EXTENDS UiEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS KeyboardEvent class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new KeyboardEvent( type.js )'.
!
type: type options: options
	"Options is a KeyboardEventOptions instance."
	^ self fromJs: INLINE 'new KeyboardEvent( type.js, options.js )'.
!

METHODS

"Key"

key
	"The value of the key, e.g. 'a', 'A', 'Enter', 'ArrowLeft'."
	^ String fromJs: INLINE 'this.js.key'.
!
code
	"The physical key, independent of the keyboard layout, e.g. 'KeyA', 'Enter', 'ArrowLeft'."
	^ String fromJs: INLINE 'this.js.code'.
!
location
	"Location of the key on the keyboard: 0 standard, 1 left, 2 right, 3 numpad."
	^ Integer fromJs: INLINE 'this.js.location'.
!
repeat
	"True if the key is held down, so the event repeats automatically."
	^ Boolean fromJs: INLINE 'this.js.repeat'.
!
isComposing
	"True if the event is fired during composition, e.g. with an input method editor."
	^ Boolean fromJs: INLINE 'this.js.isComposing'.
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
modifierState: key
	"Return true if the modifier key with the argument name was active,
	 e.g. 'Alt', 'AltGraph', 'CapsLock', 'Control', 'Meta', 'NumLock', 'Shift'."
	^ Boolean fromJs: INLINE 'this.js.getModifierState( key.js )'.
!
