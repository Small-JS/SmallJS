CLASS Geolocation EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: Geolocation.
	 Getting the position requires user permission and a secure context.
	 Success blocks are called with a GeolocationPosition,
	 error blocks with a GeolocationPositionError."

CLASSMETHODS

default
	"Return the geolocation singleton."
	^ Window default navigator geolocation.
!

METHODS

"Current position"

currentPositionThen: block
	self currentPositionThen: block error: nil options: nil.
!
currentPositionThen: block error: errorBlock
	self currentPositionThen: block error: errorBlock options: nil.
!
currentPositionThen: block error: errorBlock options: options
	"Options is a PositionOptions or nil."
	GeolocationPosition. GeolocationPositionError.	"Force import"
	INLINE 'this.js.getCurrentPosition(
		( position ) => block.$value$( stGeolocationPosition$class.$fromJs$( position ) ),
		errorBlock === stNil ? null :
			( error ) => errorBlock.$value$( stGeolocationPositionError$class.$fromJs$( error ) ),
		options.js )'.
!

"Watching"

watchPositionThen: block
	^ self watchPositionOptions: nil then: block error: nil.
!
watchPositionThen: block error: errorBlock
	^ self watchPositionOptions: nil then: block error: errorBlock.
!
watchPositionOptions: options then: block error: errorBlock
	"Options is a PositionOptions or nil.
	 The blocks are called every time the position changes.
	 Returns the watch id Integer, to be used with clearWatch:."
	GeolocationPosition. GeolocationPositionError.	"Force import"
	^ Integer fromJs: INLINE 'this.js.watchPosition(
		( position ) => block.$value$( stGeolocationPosition$class.$fromJs$( position ) ),
		errorBlock === stNil ? null :
			( error ) => errorBlock.$value$( stGeolocationPositionError$class.$fromJs$( error ) ),
		options.js )'.
!
clearWatch: watchId
	INLINE 'this.js.clearWatch( watchId.js )'.
!
