CLASS GeolocationPositionError EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: GeolocationPositionError.
 Instances are passed to the error blocks of Geolocation."

METHODS

"Properties"

code
	"Return 1: permission denied, 2: position unavailable or 3: timeout."
	^ Integer fromJs: INLINE 'this.js.code'.
!
message
	^ String fromJs: INLINE 'this.js.message'.
!

"Testing"

isPermissionDenied
	^ self code = 1.
!
isPositionUnavailable
	^ self code = 2.
!
isTimeout
	^ self code = 3.
!
