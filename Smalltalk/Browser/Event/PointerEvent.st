CLASS PointerEvent EXTENDS MouseEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS PointerEvent class."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new PointerEvent( type.js )'.
!
type: type options: options
	"Options is a PointerEventOptions instance."
	^ self fromJs: INLINE 'new PointerEvent( type.js, options.js )'.
!

METHODS

"Pointer"

pointerId
	^ Integer fromJs: INLINE 'this.js.pointerId'.
!
persistentDeviceId
	"Unique ID of the pointing device across sessions, or 0 if unavailable."
	^ Integer fromJs: INLINE 'this.js.persistentDeviceId'.
!
pointerType
	"The device type: 'mouse', 'pen', 'touch' or ''."
	^ String fromJs: INLINE 'this.js.pointerType'.
!
isPrimary
	^ Boolean fromJs: INLINE 'this.js.isPrimary'.
!

"Contact geometry"

contact
	"Size of the contact area of the pointer as a Point: width @ height."
	^ ( Float fromJs: INLINE 'this.js.width' ) @
		( Float fromJs: INLINE 'this.js.height' ).
!

"Pressure"

pressure
	"Normalized pressure from 0 to 1."
	^ Float fromJs: INLINE 'this.js.pressure'.
!
tangentialPressure
	"Normalized tangential pressure from -1 to 1."
	^ Float fromJs: INLINE 'this.js.tangentialPressure'.
!

"Orientation"

tilt
	"Tilt of the pointer as a Point: tiltX @ tiltY, angles in degrees from -90 to 90."
	^ ( Integer fromJs: INLINE 'this.js.tiltX' ) @
		( Integer fromJs: INLINE 'this.js.tiltY' ).
!
twist
	"Rotation in degrees from 0 to 359."
	^ Integer fromJs: INLINE 'this.js.twist'.
!
altitudeAngle
	"Angle in radians from 0 (parallel to the surface) to pi/2 (perpendicular)."
	^ Float fromJs: INLINE 'this.js.altitudeAngle'.
!
azimuthAngle
	"Angle in radians from 0 to 2*pi."
	^ Float fromJs: INLINE 'this.js.azimuthAngle'.
!

"Events"

coalescedEvents
	"The PointerEvents that were merged into this pointermove event."
	^ Array fromJs: INLINE 'this.js.getCoalescedEvents()'
		elementConverter: [ :jsEvent | PointerEvent fromJs: jsEvent ].
!
predictedEvents
	"The PointerEvents the browser predicts will follow this event."
	^ Array fromJs: INLINE 'this.js.getPredictedEvents()'
		elementConverter: [ :jsEvent | PointerEvent fromJs: jsEvent ].
!
