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

client
	"Position relative to the viewport as a Point: clientX @ clientY, or nil if not set.
	 If only one is set, the other has the JS default value 0."
	INLINE 'if( this.js.clientX == null && this.js.clientY == null ) return stNil$'.
	^ ( Float fromJs: INLINE 'this.js.clientX ?? 0' ) @
		( Float fromJs: INLINE 'this.js.clientY ?? 0' ).
!
client: point
	"Position relative to the viewport as a Point: clientX @ clientY."
	INLINE 'this.js.clientX = point.x.js'.
	INLINE 'this.js.clientY = point.y.js'.
!
screen
	"Position relative to the screen as a Point: screenX @ screenY, or nil if not set.
	 If only one is set, the other has the JS default value 0."
	INLINE 'if( this.js.screenX == null && this.js.screenY == null ) return stNil$'.
	^ ( Float fromJs: INLINE 'this.js.screenX ?? 0' ) @
		( Float fromJs: INLINE 'this.js.screenY ?? 0' ).
!
screen: point
	"Position relative to the screen as a Point: screenX @ screenY."
	INLINE 'this.js.screenX = point.x.js'.
	INLINE 'this.js.screenY = point.y.js'.
!
movement
	"Movement since the previous mouse event as a Point: movementX @ movementY, or nil if not set.
	 If only one is set, the other has the JS default value 0."
	INLINE 'if( this.js.movementX == null && this.js.movementY == null ) return stNil$'.
	^ ( Float fromJs: INLINE 'this.js.movementX ?? 0' ) @
		( Float fromJs: INLINE 'this.js.movementY ?? 0' ).
!
movement: point
	"Movement since the previous mouse event as a Point: movementX @ movementY."
	INLINE 'this.js.movementX = point.x.js'.
	INLINE 'this.js.movementY = point.y.js'.
!

"Events"

relatedTarget
	^ MouseEvent targetFromJs: INLINE 'this.js.relatedTarget'.
!
relatedTarget: relatedTarget
	INLINE 'this.js.relatedTarget = relatedTarget.js'.
!
