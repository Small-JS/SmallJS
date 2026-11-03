CLASS Touch EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS Touch class: a touch point of a TouchEvent, like a finger on a touch screen.
	 Like TouchEvent, desktop browsers without a touch screen may not have this class."

CLASSMETHODS

new
	self error: 'Create a new Touch with: Touch options:'.
!
options: options
	"Options is a TouchOptions instance, which must contain identifier and target."
	^ self fromJs: INLINE 'new Touch( options.js )'.
!

METHODS

"Identity"

identifier
	"Unique for the touch point while it is on the screen, also in other events."
	^ Integer fromJs: INLINE 'this.js.identifier'.
!
target
	"The element where the touch started, also when the touch point moved outside it."
	^ MouseEvent targetFromJs: INLINE 'this.js.target'.
!

"Positions"

client
	^ ( Float fromJs: INLINE 'this.js.clientX' ) @
		( Float fromJs: INLINE 'this.js.clientY' ).
!
page
	^ ( Float fromJs: INLINE 'this.js.pageX' ) @
		( Float fromJs: INLINE 'this.js.pageY' ).
!
screen
	^ ( Float fromJs: INLINE 'this.js.screenX' ) @
		( Float fromJs: INLINE 'this.js.screenY' ).
!

"Contact geometry"

radius
	"The radii of the ellipse that most closely covers the contact area, as a Point."
	^ ( Float fromJs: INLINE 'this.js.radiusX' ) @
		( Float fromJs: INLINE 'this.js.radiusY' ).
!
rotationAngle
	"The rotation of the radius ellipse in degrees, from 0 to 90."
	^ Float fromJs: INLINE 'this.js.rotationAngle'.
!
force
	"The pressure, from 0 to 1. 0 if not supported."
	^ Float fromJs: INLINE 'this.js.force'.
!
