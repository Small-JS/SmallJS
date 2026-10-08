CLASS MouseEventOptions EXTENDS UiEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a MouseEvent instance."

METHODS

"Keys"

altKey
	^ Boolean fromJs: INLINE 'this.js.altKey'.
!
altKey: altKey
	INLINE 'this.js.altKey = altKey.js'.
!
ctrlKey
	^ Boolean fromJs: INLINE 'this.js.ctrlKey'.
!
ctrlKey: ctrlKey
	INLINE 'this.js.ctrlKey = ctrlKey.js'.
!
metaKey
	^ Boolean fromJs: INLINE 'this.js.metaKey'.
!
metaKey: metaKey
	INLINE 'this.js.metaKey = metaKey.js'.
!
shiftKey
	^ Boolean fromJs: INLINE 'this.js.shiftKey'.
!
shiftKey: shiftKey
	INLINE 'this.js.shiftKey = shiftKey.js'.
!

"Buttons"

button
	^ Integer fromJs: INLINE 'this.js.button'.
!
button: button
	INLINE 'this.js.button = button.js'.
!
buttons
	^ Integer fromJs: INLINE 'this.js.buttons'.
!
buttons: buttons
	INLINE 'this.js.buttons = buttons.js'.
!

"Positions"

clientX
	^ Float fromJs: INLINE 'this.js.clientX'.
!
clientX: clientX
	INLINE 'this.js.clientX = clientX.js'.
!
clientY
	^ Float fromJs: INLINE 'this.js.clientY'.
!
clientY: clientY
	INLINE 'this.js.clientY = clientY.js'.
!
screenX
	^ Float fromJs: INLINE 'this.js.screenX'.
!
screenX: screenX
	INLINE 'this.js.screenX = screenX.js'.
!
screenY
	^ Float fromJs: INLINE 'this.js.screenY'.
!
screenY: screenY
	INLINE 'this.js.screenY = screenY.js'.
!
movementX
	^ Float fromJs: INLINE 'this.js.movementX'.
!
movementX: movementX
	INLINE 'this.js.movementX = movementX.js'.
!
movementY
	^ Float fromJs: INLINE 'this.js.movementY'.
!
movementY: movementY
	INLINE 'this.js.movementY = movementY.js'.
!

"Events"

relatedTarget
	^ EventTarget fromJs: INLINE 'this.js.relatedTarget'.
!
relatedTarget: relatedTarget
	INLINE 'this.js.relatedTarget = relatedTarget.js'.
!
