CLASS TestScreenOrientation EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| screenOrientation |
	screenOrientation := Window default screen orientation.

	self assert: [ screenOrientation class = ScreenOrientation ].

	self assert: [
		#( 'portrait-primary' 'portrait-secondary' 'landscape-primary' 'landscape-secondary' )
			includes: screenOrientation type ].

	self assert: [ screenOrientation angle class = Integer ].
	self assert: [ #( 0 90 180 270 ) includes: screenOrientation angle ].

	screenOrientation lock: 'any' onLocked: [] onError: [].
	screenOrientation unlock.
!
async testLockError
	"Test with a mock JS object, because locking depends on fullscreen and browser support."
	| screenOrientation error |
	screenOrientation := ScreenOrientation fromJs: INLINE '( {
		lock() { return Promise.reject( new Error( "Lock not allowed" ) ) } } )'.
	screenOrientation lock: 'portrait' onLocked: [] onError: [ :anError | error := anError ].
	await Timer timeout: 0.
	self assert: [ error class = Error ].
	self assert: [ error message = 'Lock not allowed' ].
!
