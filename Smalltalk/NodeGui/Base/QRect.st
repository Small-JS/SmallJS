CLASS QRect EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

"A rectangle with integer coordinates, defined by its left and top, and its width and height."

CLASSMETHODS

new
	"Answer a null rectangle, with width and height 0."
	^ self fromJs: INLINE 'new nodegui$.QRect()'.
!
left: left top: top width: width height: height
	^ self fromJs: INLINE 'new nodegui$.QRect( left.js, top.js, width.js, height.js )'.
!
fromVariant: variant
	"Answer the rectangle held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QRect.fromQVariant( variant.js )'.
!

METHODS

"Comparing"

= rect
	"Rectangles are equal if their left, top, width and height are equal."
	^ ( rect isKindOf: QRect ) and: [
		( self left = rect left ) & ( self top = rect top ) & ( self width = rect width ) & ( self height = rect height ) ].
!

"Accessing"

left
	^ Integer fromJs: INLINE 'this.js.left()'.
!
setLeft: left
	"Moves the left edge, changing the width."
	INLINE 'this.js.setLeft( left.js )'.
!
top
	^ Integer fromJs: INLINE 'this.js.top()'.
!
setTop: top
	"Moves the top edge, changing the height."
	INLINE 'this.js.setTop( top.js )'.
!
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
topLeft
	^ QPoint x: self left y: self top.
!
size
	^ QSize width: self width height: self height.
!

"Printing"

toString
	^ 'QRect( ', self left toString, ', ', self top toString, ', ', self width toString, ', ', self height toString, ' )'.
!
