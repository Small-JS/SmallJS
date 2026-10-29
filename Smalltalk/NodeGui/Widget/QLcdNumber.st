CLASS QLcdNumber EXTENDS QFrame MODULE NodeGui CLASSVARS '' VARS ''

"Shows a number with LCD-like digits. The JS and Qt class is QLCDNumber.
 It can show digits 0-9, A-F, some letters, '.', '-', ':' and spaces."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QLCDNumber()'.
!

"Mode enums"

hex
	^ 0.
!
dec
	^ 1.
!
oct
	^ 2.
!
bin
	^ 3.
!

"Segment style enums"

outline
	^ 0.
!
filled
	^ 1.
!
flat
	^ 2.
!

METHODS

"Value"

display: value
	"Value can be a Number or a String, e.g. '12:30'."
	INLINE 'this.js.display( value.js )'.
!
value
	"Answer the number shown, or 0 for a String that is not a number."
	^ Float fromJs: INLINE 'this.js.value()'.
!
intValue
	"Answer the number shown, rounded."
	^ Integer fromJs: INLINE 'this.js.intValue()'.
!
checkOverflow: number
	"Answer true if number does not fit in the digits."
	^ Boolean fromJs: INLINE 'this.js.checkOverflow( number.js )'.
!

"Appearance"

setDigitCount: digitCount
	"The default is 5."
	INLINE 'this.js.setDigitCount( digitCount.js )'.
!
digitCount
	^ Integer fromJs: INLINE 'this.js.digitCount()'.
!
setMode: mode
	"Use the mode enums. The default is dec."
	INLINE 'this.js.setMode( mode.js )'.
!
mode
	^ Integer fromJs: INLINE 'this.js.mode()'.
!
setSegmentStyle: segmentStyle
	"Use the segment style enums. The default is filled."
	INLINE 'this.js.setSegmentStyle( segmentStyle.js )'.
!
segmentStyle
	^ Integer fromJs: INLINE 'this.js.segmentStyle()'.
!
setSmallDecimalPoint: small
	"If small, the decimal point is shown between two digits, instead of using a digit."
	INLINE 'this.js.setSmallDecimalPoint( small.js )'.
!
smallDecimalPoint
	^ Boolean fromJs: INLINE 'this.js.smallDecimalPoint()'.
!

"Events"

onOverflow: block
	"Block is called when a value is displayed that does not fit in the digits."
	self addEventListener: 'overflow' then: [ block value ].
!
