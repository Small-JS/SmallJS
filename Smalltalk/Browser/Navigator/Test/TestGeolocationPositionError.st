CLASS TestGeolocationPositionError EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: A GeolocationPositionError can not be constructed in JS,
 so the instance methods are tested with plain JS objects."

METHODS

testCodes
	"The is* methods use these code numbers directly."
	self assert: [ ( Integer fromJs: INLINE 'GeolocationPositionError.PERMISSION_DENIED' ) = 1 ].
	self assert: [ ( Integer fromJs: INLINE 'GeolocationPositionError.POSITION_UNAVAILABLE' ) = 2 ].
	self assert: [ ( Integer fromJs: INLINE 'GeolocationPositionError.TIMEOUT' ) = 3 ].
!
test
	| error |
	error := GeolocationPositionError fromJs: INLINE '{ code: 1, message: "User denied Geolocation" }'.
	self assert: [ error code = 1 ].
	self assert: [ error message = 'User denied Geolocation' ].
	self assert: [ error isPermissionDenied ].
	self assert: [ error isPositionUnavailable not ].
	self assert: [ error isTimeout not ].

	error := GeolocationPositionError fromJs: INLINE '{ code: 2, message: "" }'.
	self assert: [ error isPositionUnavailable ].
	self assert: [ error isPermissionDenied not ].
!
