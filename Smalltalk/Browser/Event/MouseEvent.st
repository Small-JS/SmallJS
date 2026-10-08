CLASS MouseEvent EXTENDS UiEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS MouseEvent class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new MouseEvent( type.js )'.
!
type: type options: options
	"Options is a MouseEventOptions instance."
	^ self fromJs: INLINE 'new MouseEvent( type.js, options.js )'.
!

METHODS

"Keys"

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

"Buttons"

button
	^ Integer fromJs: INLINE 'this.js.button'.
!
buttons
	^ Integer fromJs: INLINE 'this.js.buttons'.
!

"Positions"

client
	^ ( Float fromJs: INLINE 'this.js.clientX' ) @
		( Float fromJs: INLINE 'this.js.clientY' ).
!
offset
	^ ( Float fromJs: INLINE 'this.js.offsetX' ) @
		( Float fromJs: INLINE 'this.js.offsetY' ).
!
page
	^ ( Float fromJs: INLINE 'this.js.pageX' ) @
		( Float fromJs: INLINE 'this.js.pageY' ).
!
screen
	^ ( Float fromJs: INLINE 'this.js.screenX' ) @
		( Float fromJs: INLINE 'this.js.screenY' ).
!
movement
	^ ( Float fromJs: INLINE 'this.js.movementX' ) @
		( Float fromJs: INLINE 'this.js.movementY' ).
!

"Events"

relatedTarget
	"The secondary target of the event, e.g. the element left for mouseenter, or nil."
	^ EventTarget fromJs: INLINE 'this.js.relatedTarget'.
!
