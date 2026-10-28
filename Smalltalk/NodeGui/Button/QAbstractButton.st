CLASS QAbstractButton EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"Abstract base class of button widgets, like QPushButton.
 Signals: 'clicked', 'pressed', 'released', 'toggled'."

METHODS

"Text and icon"

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	^ String fromJs: INLINE 'this.js.text()'.
!
setIcon: icon
	INLINE 'this.js.setIcon( icon.js )'.
!
icon
	^ QIcon fromJs: INLINE 'this.js.icon()'.
!

"Actions"

click
	"Perform a click, emitting the signals as if the user clicked the button."
	INLINE 'this.js.click()'.
!
animateClick
	"Perform an animated click: the button is shown pressed for a short time, then clicked."
	INLINE 'this.js.animateClick()'.
!
toggle
	"Toggle the checked state of a checkable button."
	INLINE 'this.js.toggle()'.
!

"Events"

onClick: block
	self addEventListener: 'clicked' then: [ block value ].
!
onToggle: block
	self addEventListener: 'toggled' then: [ block value ].
!

"Checking"

setCheckable: checkable
	INLINE 'this.js.setCheckable( checkable.js )'.
!
isCheckable
	^ Boolean fromJs: INLINE 'this.js.isCheckable()'.
!
setChecked: checked
	"Only has effect if the button is checkable."
	INLINE 'this.js.setChecked( checked.js )'.
!
isChecked
	^ Boolean fromJs: INLINE 'this.js.isChecked()'.
!
setAutoExclusive: enable
	"If enabled, only one checkable button with the same parent widget can be checked."
	INLINE 'this.js.setAutoExclusive( enable.js )'.
!
autoExclusive
	^ Boolean fromJs: INLINE 'this.js.autoExclusive()'.
!
setDown: down
	"Set if the button is shown pressed down."
	INLINE 'this.js.setDown( down.js )'.
!
isDown
	^ Boolean fromJs: INLINE 'this.js.isDown()'.
!

"Auto repeat"

setAutoRepeat: enable
	"If enabled, the button emits 'clicked' repeatedly while it is held down."
	INLINE 'this.js.setAutoRepeat( enable.js )'.
!
autoRepeat
	^ Boolean fromJs: INLINE 'this.js.autoRepeat()'.
!
setAutoRepeatDelay: delay
	"Set the delay in milliseconds before auto repeat starts."
	INLINE 'this.js.setAutoRepeatDelay( delay.js )'.
!
autoRepeatDelay
	^ Integer fromJs: INLINE 'this.js.autoRepeatDelay()'.
!
setAutoRepeatInterval: interval
	"Set the interval in milliseconds between auto repeats."
	INLINE 'this.js.setAutoRepeatInterval( interval.js )'.
!
autoRepeatInterval
	^ Integer fromJs: INLINE 'this.js.autoRepeatInterval()'.
!
