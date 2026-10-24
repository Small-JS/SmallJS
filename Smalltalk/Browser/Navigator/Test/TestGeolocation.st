CLASS TestGeolocation EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Getting the real position requires user permission,
 so the callback handling is tested with a mock JS geolocation object.
 The mock calls the success block if options.timeout is not 0, otherwise the error block.
 It stores the passed options in: lastOptions, and the cleared watch id in: clearedId."

METHODS

test
	| geolocation |
	geolocation := Window default navigator geolocation.
	self assert: [ geolocation class = Geolocation ].
	self assert: [ Geolocation default = geolocation ].
!
testCurrentPosition
	| geolocation position coords |
	geolocation := self mockGeolocation.
	geolocation currentPositionThen: [ :aPosition | position := aPosition ].
	self assert: [ position class = GeolocationPosition ].
	self assert: [ position timestamp = 1000 ].
	coords := position coords.
	self assert: [ coords class = GeolocationCoordinates ].
	self assert: [ coords latitude = 52.5 ].
	self assert: [ coords longitude = 4.25 ].
	self assert: [ coords accuracy = 10 ].
	self assert: [ coords altitude = 1.5 ].
	self assert: [ coords altitudeAccuracy isNil ].
	self assert: [ coords heading isNil ].
	self assert: [ coords speed isNil ].
	self assert: [ Boolean fromJs: INLINE 'geolocation.js.lastOptions === null' ].
!
testCurrentPositionError
	| geolocation position error |
	geolocation := self mockGeolocation.
	geolocation
		currentPositionThen: [ :aPosition | position := aPosition ]
		error: [ :anError | error := anError ]
		options: ( PositionOptions new timeout: 0 ).
	self assert: [ position isNil ].
	self assert: [ error class = GeolocationPositionError ].
	self assert: [ error code = 3 ].
	self assert: [ error message = 'Timeout expired' ].
	self assert: [ error isTimeout ].
	self assert: [ error isPermissionDenied not ].
	self assert: [ error isPositionUnavailable not ].
!
testCurrentPositionOptions
	| geolocation position options |
	geolocation := self mockGeolocation.
	options := PositionOptions new enableHighAccuracy: true; maximumAge: 500; timeout: 2000.
	geolocation
		currentPositionThen: [ :aPosition | position := aPosition ]
		error: [ :anError | ]
		options: options.
	self assert: [ position coords latitude = 52.5 ].
	self assert: [ Boolean fromJs: INLINE 'geolocation.js.lastOptions === options.js' ].
!
testWatchPosition
	| geolocation position count watchId |
	geolocation := self mockGeolocation.
	count := 0.
	watchId := geolocation watchPositionThen: [ :aPosition | position := aPosition. count := count + 1 ].
	self assert: [ watchId = 42 ].
	self assert: [ count = 1 ].
	self assert: [ position coords longitude = 4.25 ].

	geolocation clearWatch: watchId.
	self assert: [ ( geolocation atJsProperty: 'clearedId' ) = 42 ].
!
testWatchPositionError
	| geolocation error watchId |
	geolocation := self mockGeolocation.
	watchId := geolocation
		watchPositionThen: [ :aPosition | ]
		error: [ :anError | error := anError ]
		options: ( PositionOptions new timeout: 0 ).
	self assert: [ watchId = 42 ].
	self assert: [ error isTimeout ].
!
testClearWatch
	"Only clearing a non-existing watch is tested on the real geolocation, because watching requires permission."
	Geolocation default clearWatch: 12345.
!

"Private"

mockGeolocation
	^ Geolocation fromJs: INLINE '{
		position: { timestamp: 1000, coords: {
			latitude: 52.5, longitude: 4.25, accuracy: 10, altitude: 1.5,
			altitudeAccuracy: null, heading: null, speed: null } },
		report( success, error, options ) {
			this.lastOptions = options;
			if( options?.timeout === 0 ) error( { code: 3, message: "Timeout expired" } );
			else success( this.position ); },
		getCurrentPosition( success, error, options ) { this.report( success, error, options ); },
		watchPosition( success, error, options ) { this.report( success, error, options ); return 42; },
		clearWatch( id ) { this.clearedId = id; } }'.
!
