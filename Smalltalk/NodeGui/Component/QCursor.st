CLASS QCursor EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

"A mouse cursor, used with QWidget setCursor:.
 The class methods pos and setPos: get and set the position of the mouse on the screen."

CLASSMETHODS

new
	"Answer an arrow cursor."
	^ self fromJs: INLINE 'new nodegui$.QCursor()'.
!
new: cursorShape
	"Use the QWidget cursor shape enums."
	^ self fromJs: INLINE 'new nodegui$.QCursor( cursorShape.js )'.
!

"Mouse position"

pos
	"Answer the position of the mouse, in screen coordinates.
	 JS pos() answers a plain object, so make a QPoint."
	^ QPoint fromJs: INLINE '( () => {
		const pos = new nodegui$.QCursor().pos();
		return new nodegui$.QPoint( pos.x, pos.y ) } )()'.
!
setPos: point
	"Move the mouse to point, in screen coordinates."
	INLINE 'new nodegui$.QCursor().setPos( point.$x().js, point.$y().js )'.
!
