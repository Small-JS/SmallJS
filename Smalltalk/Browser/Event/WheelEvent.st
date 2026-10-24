CLASS WheelEvent EXTENDS MouseEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS WheelEvent class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new WheelEvent( type.js )'.
!
type: type options: options
	"Options is a WheelEventOptions instance."
	^ self fromJs: INLINE 'new WheelEvent( type.js, options.js )'.
!

"Delta modes"

deltaPixel
	^ Integer fromJs: INLINE 'WheelEvent.DOM_DELTA_PIXEL'.
!
deltaLine
	^ Integer fromJs: INLINE 'WheelEvent.DOM_DELTA_LINE'.
!
deltaPage
	^ Integer fromJs: INLINE 'WheelEvent.DOM_DELTA_PAGE'.
!

METHODS

"Wheel"

delta
	"Scroll amount as a Point3d: deltaX @ deltaY @ deltaZ, in units of deltaMode."
	^ Point3d
		x: ( Float fromJs: INLINE 'this.js.deltaX' )
		y: ( Float fromJs: INLINE 'this.js.deltaY' )
		z: ( Float fromJs: INLINE 'this.js.deltaZ' ).
!
deltaMode
	"Unit of the delta values: WheelEvent deltaPixel, deltaLine or deltaPage."
	^ Integer fromJs: INLINE 'this.js.deltaMode'.
!
