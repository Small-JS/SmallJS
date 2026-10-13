CLASS PositionOptions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS options object for getting a position with Geolocation."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

enableHighAccuracy
	^ Boolean fromJs: INLINE 'this.js.enableHighAccuracy'.
!
enableHighAccuracy: enableHighAccuracy
	INLINE 'this.js.enableHighAccuracy = enableHighAccuracy.js'.
!
maximumAge
	"Return the maximum age in milliseconds of a cached position that is acceptable to return."
	^ Integer fromJs: INLINE 'this.js.maximumAge'.
!
maximumAge: maximumAge
	INLINE 'this.js.maximumAge = maximumAge.js'.
!
timeout
	"Return the maximum time in milliseconds allowed to get the position."
	^ Integer fromJs: INLINE 'this.js.timeout'.
!
timeout: timeout
	INLINE 'this.js.timeout = timeout.js'.
!
