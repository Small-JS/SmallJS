CLASS QProgressBar EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"Shows progress as a bar, from minimum to maximum. The default range is 0 to 100.
 If minimum and maximum are both 0, the bar shows a busy indicator."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QProgressBar()'.
!

"Orientation enums"

horizontal
	^ 1.
!
vertical
	^ 2.
!

"Text direction enums, for a vertical bar"

topToBottom
	^ 0.
!
bottomToTop
	^ 1.
!

METHODS

"Value"

setValue: value
	"Value outside the range is ignored."
	INLINE 'this.js.setValue( value.js )'.
!
value
	"Answer minimum - 1 after reset."
	^ Integer fromJs: INLINE 'this.js.value()'.
!
reset
	"Rewind the bar, it shows no progress. Does not fire a 'valueChanged' event."
	INLINE 'this.js.reset()'.
!
setMinimum: minimum
	INLINE 'this.js.setMinimum( minimum.js )'.
!
minimum
	^ Integer fromJs: INLINE 'this.js.minimum()'.
!
setMaximum: maximum
	INLINE 'this.js.setMaximum( maximum.js )'.
!
maximum
	^ Integer fromJs: INLINE 'this.js.maximum()'.
!
setMinimum: minimum maximum: maximum
	INLINE 'this.js.setRange( minimum.js, maximum.js )'.
!

"Text"

text
	"Answer the text shown, e.g. '30%'."
	^ String fromJs: INLINE 'this.js.text()'.
!
setFormat: format
	"In format, %p is the percentage, %v the value, %m the number of steps. The default is '%p%'."
	INLINE 'this.js.setFormat( format.js )'.
!
format
	^ String fromJs: INLINE 'this.js.format()'.
!
resetFormat
	INLINE 'this.js.resetFormat()'.
!
setTextVisible: visible
	INLINE 'this.js.setTextVisible( visible.js )'.
!
isTextVisible
	^ Boolean fromJs: INLINE 'this.js.isTextVisible()'.
!
setTextDirection: textDirection
	"Use the text direction enums."
	INLINE 'this.js.setTextDirection( textDirection.js )'.
!
textDirection
	^ Integer fromJs: INLINE 'this.js.textDirection()'.
!

"Appearance"

setOrientation: orientation
	"Use the orientation enums."
	INLINE 'this.js.setOrientation( orientation.js )'.
!
orientation
	^ Integer fromJs: INLINE 'this.js.orientation()'.
!
setInvertedAppearance: inverted
	"If inverted, the bar grows in the other direction."
	INLINE 'this.js.setInvertedAppearance( inverted.js )'.
!
invertedAppearance
	^ Boolean fromJs: INLINE 'this.js.invertedAppearance()'.
!
setAlignment: alignment
	"Alignment of the text, use the QLayout alignment enums."
	INLINE 'this.js.setAlignment( alignment.js )'.
!
alignment
	^ Integer fromJs: INLINE 'this.js.alignment()'.
!

"Events"

onValueChange: block
	self addEventListener: 'valueChanged' then: [ block value ].
!
