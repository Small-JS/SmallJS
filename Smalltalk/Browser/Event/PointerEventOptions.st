CLASS PointerEventOptions EXTENDS MouseEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a PointerEvent instance."

METHODS

"Pointer"

pointerId
	^ Integer fromJs: INLINE 'this.js.pointerId'.
!
pointerId: pointerId
	INLINE 'this.js.pointerId = pointerId.js'.
!
pointerType
	^ String fromJs: INLINE 'this.js.pointerType'.
!
pointerType: pointerType
	INLINE 'this.js.pointerType = pointerType.js'.
!
isPrimary
	^ Boolean fromJs: INLINE 'this.js.isPrimary'.
!
isPrimary: isPrimary
	INLINE 'this.js.isPrimary = isPrimary.js'.
!

"Contact geometry"

contact
	"Size of the contact area of the pointer as a Point: width @ height, or nil if not set."
	INLINE 'if( this.js.width == null && this.js.height == null ) return stNil'.
	^ ( Float fromJs: INLINE 'this.js.width' ) @
		( Float fromJs: INLINE 'this.js.height' ).
!
contact: point
	"Size of the contact area of the pointer as a Point: width @ height."
	INLINE 'this.js.width = point.x.js'.
	INLINE 'this.js.height = point.y.js'.
!

"Pressure"

pressure
	^ Float fromJs: INLINE 'this.js.pressure'.
!
pressure: pressure
	INLINE 'this.js.pressure = pressure.js'.
!
tangentialPressure
	^ Float fromJs: INLINE 'this.js.tangentialPressure'.
!
tangentialPressure: tangentialPressure
	INLINE 'this.js.tangentialPressure = tangentialPressure.js'.
!

"Orientation"

tilt
	"Tilt of the pointer as a Point: tiltX @ tiltY, or nil if not set."
	INLINE 'if( this.js.tiltX == null && this.js.tiltY == null ) return stNil'.
	^ ( Integer fromJs: INLINE 'this.js.tiltX' ) @
		( Integer fromJs: INLINE 'this.js.tiltY' ).
!
tilt: point
	"Tilt of the pointer as a Point: tiltX @ tiltY, angles in degrees from -90 to 90."
	INLINE 'this.js.tiltX = point.x.js'.
	INLINE 'this.js.tiltY = point.y.js'.
!
twist
	^ Integer fromJs: INLINE 'this.js.twist'.
!
twist: twist
	INLINE 'this.js.twist = twist.js'.
!
altitudeAngle
	^ Float fromJs: INLINE 'this.js.altitudeAngle'.
!
altitudeAngle: altitudeAngle
	INLINE 'this.js.altitudeAngle = altitudeAngle.js'.
!
azimuthAngle
	^ Float fromJs: INLINE 'this.js.azimuthAngle'.
!
azimuthAngle: azimuthAngle
	INLINE 'this.js.azimuthAngle = azimuthAngle.js'.
!
