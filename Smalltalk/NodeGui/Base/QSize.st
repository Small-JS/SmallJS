CLASS QSize EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

"A two-dimensional size, with an integer width and height.
 Sizes with a negative width or height are invalid."

CLASSMETHODS

new
	"Answer an invalid size, with width and height -1."
	^ self fromJs: INLINE 'new nodegui$.QSize()'.
!
width: width height: height
	"JS new QSize( 0, height ) answers an invalid size, so set width and height separately."
	^ self new setWidth: width; setHeight: height.
!
fromVariant: variant
	"Answer the size held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QSize.fromQVariant( variant.js )'.
!

"Aspect ratio mode enums, used by scaled:"

ignoreAspectRatio
	^ 0.
!
keepAspectRatio
	^ 1.
!
keepAspectRatioByExpanding
	^ 2.
!

METHODS

"Comparing"

= size
	"Sizes are equal if their width and height are equal."
	^ ( size isKindOf: QSize ) and: [ ( self width = size width ) & ( self height = size height ) ].
!

"Accessing"

width
	^ Integer fromJs: INLINE 'this.js.width()'.
!
setWidth: width
	INLINE 'this.js.setWidth( width.js )'.
!
height
	^ Integer fromJs: INLINE 'this.js.height()'.
!
setHeight: height
	INLINE 'this.js.setHeight( height.js )'.
!

"Testing"

isEmpty
	"Answer true if width or height is less than or equal to 0."
	^ Boolean fromJs: INLINE 'this.js.isEmpty()'.
!
isNull
	"Answer true if both width and height are 0."
	^ Boolean fromJs: INLINE 'this.js.isNull()'.
!
isValid
	"Answer true if both width and height are greater than or equal to 0."
	^ Boolean fromJs: INLINE 'this.js.isValid()'.
!

"Converting"

boundedTo: size
	"Answer a size with the minimum width and height of this size and size.
	 JS boundedTo() does not unwrap its argument, so pass the native object."
	^ QSize fromJs: INLINE 'this.js.boundedTo( size.js.native )'.
!
expandedTo: size
	"Answer a size with the maximum width and height of this size and size.
	 JS expandedTo() does not unwrap its argument, so pass the native object."
	^ QSize fromJs: INLINE 'this.js.expandedTo( size.js.native )'.
!
transpose
	"Swap width and height."
	INLINE 'this.js.transpose()'.
!
transposed
	"Answer a new size with width and height swapped."
	^ QSize fromJs: INLINE 'this.js.transposed()'.
!
scale: size mode: mode
	"Scale to size, using an aspect ratio mode enum, e.g. QSize keepAspectRatio."
	INLINE 'this.js.scale( size.$width().js, size.$height().js, mode.js )'.
!
scaled: size mode: mode
	"Answer a new size scaled to size, using an aspect ratio mode enum."
	^ QSize fromJs: INLINE 'this.js.scaled( size.$width().js, size.$height().js, mode.js )'.
!

"Printing"

toString
	^ 'QSize( ', self width toString, ', ', self height toString, ' )'.
!
