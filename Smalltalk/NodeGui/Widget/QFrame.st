CLASS QFrame EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A widget with a frame, defined by its shape and shadow.
 A frame with shape hLine or vLine is a separator line."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QFrame()'.
!

"Shape enums"

noFrame
	^ 0.
!
box
	^ 1.
!
panel
	"A raised or sunken panel, depending on the shadow."
	^ 2.
!
winPanel
	^ 3.
!
hLine
	"A horizontal line, without a frame."
	^ 4.
!
vLine
	"A vertical line, without a frame."
	^ 5.
!
styledPanel
	"A panel drawn by the current style."
	^ 6.
!

"Shadow enums"

plain
	^ 16.
!
raised
	^ 32.
!
sunken
	^ 48.
!

METHODS

setFrameShape: shape
	"Use the shape enums."
	INLINE 'this.js.setFrameShape( shape.js )'.
!
frameShape
	^ Integer fromJs: INLINE 'this.js.frameShape()'.
!
setFrameShadow: shadow
	"Use the shadow enums."
	INLINE 'this.js.setFrameShadow( shadow.js )'.
!
frameShadow
	^ Integer fromJs: INLINE 'this.js.frameShadow()'.
!
setLineWidth: lineWidth
	INLINE 'this.js.setLineWidth( lineWidth.js )'.
!
lineWidth
	^ Integer fromJs: INLINE 'this.js.lineWidth()'.
!
setMidLineWidth: midLineWidth
	"The width of the middle line, of a raised or sunken box or line."
	INLINE 'this.js.setMidLineWidth( midLineWidth.js )'.
!
midLineWidth
	^ Integer fromJs: INLINE 'this.js.midLineWidth()'.
!
frameWidth
	"Answer the total width of the frame, depending on the shape, shadow and line widths."
	^ Integer fromJs: INLINE 'this.js.frameWidth()'.
!
