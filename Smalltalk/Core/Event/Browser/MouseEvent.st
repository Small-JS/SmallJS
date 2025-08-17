CLASS MouseEvent EXTENDS UiEvent MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS MouseEvent class."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new MouseEvent()'.
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

"Bottons"

button
	^ Integer fromJs: INLINE 'this.js.button'.
!
buttons
	^ Integer fromJs: INLINE 'this.js.buttons'.
!

"Positions"

client
	^ ( Integer fromJs: INLINE 'this.js.clientX' ) @
		( Integer fromJs: INLINE 'this.js.clientY' ).
!
layer
	^ ( Integer fromJs: INLINE 'this.js.layerX' ) @
		( Integer fromJs: INLINE 'this.js.layerY' ).
!
offset
	^ ( Integer fromJs: INLINE 'this.js.offsetX' ) @
		( Integer fromJs: INLINE 'this.js.offsetY' ).
!
page
	^ ( Integer fromJs: INLINE 'this.js.pageX' ) @
		( Integer fromJs: INLINE 'this.js.pageY' ).
!
screen
	^ ( Integer fromJs: INLINE 'this.js.screenX' ) @
		( Integer fromJs: INLINE 'this.js.screenY' ).
!
movement
	^ ( Integer fromJs: INLINE 'this.js.movementX' ) @
		( Integer fromJs: INLINE 'this.js.movementY' ).
!

"Events"

relatedTarget
	^ EventTarget fromJs: INLINE 'this.js.buttons'.
!

