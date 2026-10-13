CLASS GeolocationCoordinates EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: GeolocationCoordinates.
 Get it with: GeolocationPosition coords.
 Optional properties return nil if the device cannot provide them."

METHODS

"Properties"

latitude
	"Return the latitude in decimal degrees."
	^ Float fromJs: INLINE 'this.js.latitude'.
!
longitude
	"Return the longitude in decimal degrees."
	^ Float fromJs: INLINE 'this.js.longitude'.
!
accuracy
	"Return the accuracy of latitude and longitude in meters."
	^ Float fromJs: INLINE 'this.js.accuracy'.
!
altitude
	"Return the altitude in meters above the WGS84 ellipsoid, or nil."
	^ Float fromJs: INLINE 'this.js.altitude'.
!
altitudeAccuracy
	"Return the accuracy of the altitude in meters, or nil."
	^ Float fromJs: INLINE 'this.js.altitudeAccuracy'.
!
heading
	"Return the direction of travel in degrees clockwise from true north, or nil.
	 Returns NaN if the device is not moving."
	^ Float fromJs: INLINE 'this.js.heading'.
!
speed
	"Return the ground speed in meters per second, or nil."
	^ Float fromJs: INLINE 'this.js.speed'.
!
