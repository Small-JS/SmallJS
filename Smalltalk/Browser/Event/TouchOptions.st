CLASS TouchOptions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a Touch instance."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Identity"

identifier
	^ Integer fromJs: INLINE 'this.js.identifier'.
!
identifier: identifier
	"Required."
	INLINE 'this.js.identifier = identifier.js'.
!
target
	^ MouseEvent targetFromJs: INLINE 'this.js.target'.
!
target: target
	"Required. An EventTarget, usually an Element."
	INLINE 'this.js.target = target.js'.
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
page
	"Position relative to the document as a Point: pageX @ pageY, or nil if not set.
	 If only one is set, the other has the JS default value 0."
	INLINE 'if( this.js.pageX == null && this.js.pageY == null ) return stNil$'.
	^ ( Float fromJs: INLINE 'this.js.pageX ?? 0' ) @
		( Float fromJs: INLINE 'this.js.pageY ?? 0' ).
!
page: point
	"Position relative to the document as a Point: pageX @ pageY."
	INLINE 'this.js.pageX = point.x.js'.
	INLINE 'this.js.pageY = point.y.js'.
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

"Contact geometry"

radius
	"Radii of the ellipse that covers the contact area as a Point: radiusX @ radiusY, or nil if not set.
	 If only one is set, the other has the JS default value 0."
	INLINE 'if( this.js.radiusX == null && this.js.radiusY == null ) return stNil$'.
	^ ( Float fromJs: INLINE 'this.js.radiusX ?? 0' ) @
		( Float fromJs: INLINE 'this.js.radiusY ?? 0' ).
!
radius: point
	"Radii of the ellipse that covers the contact area as a Point: radiusX @ radiusY."
	INLINE 'this.js.radiusX = point.x.js'.
	INLINE 'this.js.radiusY = point.y.js'.
!
rotationAngle
	^ Float fromJs: INLINE 'this.js.rotationAngle'.
!
rotationAngle: rotationAngle
	INLINE 'this.js.rotationAngle = rotationAngle.js'.
!
force
	^ Float fromJs: INLINE 'this.js.force'.
!
force: force
	INLINE 'this.js.force = force.js'.
!
