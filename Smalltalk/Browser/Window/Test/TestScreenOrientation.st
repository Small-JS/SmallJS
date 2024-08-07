CLASS TestScreenOrientation EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| screenOrientation |
	screenOrientation := Window default screen orientation.

	self assert: [ screenOrientation class = ScreenOrientation ].

	self assert: [
		#( 'portrait-primary' 'portrait-secondary' 'landscape-primary' 'landscape-secondary' )
			includes: screenOrientation type ].

	self assert: [ screenOrientation angle >= 0 ].

	screenOrientation lock: 'any' onLocked: [] onError: [].
	screenOrientation unlock.
!
