CLASS GeolocationPosition EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: GeolocationPosition.
 Instances are passed to the success blocks of Geolocation."

METHODS

"Properties"

coords
	^ GeolocationCoordinates fromJs: INLINE 'this.js.coords'.
!
timestamp
	"Return the time the position was acquired, in milliseconds since the epoch."
	^ Integer fromJs: INLINE 'this.js.timestamp'.
!
