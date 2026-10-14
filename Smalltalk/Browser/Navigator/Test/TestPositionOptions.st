CLASS TestPositionOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := PositionOptions new.
	self assert: [ options class = PositionOptions ].
	self assert: [ options enableHighAccuracy isNil ].
	self assert: [ options maximumAge isNil ].
	self assert: [ options timeout isNil ].

	options enableHighAccuracy: true.
	self assert: [ options enableHighAccuracy ].
	options maximumAge: 1000.
	self assert: [ options maximumAge = 1000 ].
	options timeout: 5000.
	self assert: [ options timeout = 5000 ].

	options := PositionOptions new enableHighAccuracy: false; maximumAge: 0; timeout: 100.
	self assert: [ options enableHighAccuracy not ].
	self assert: [ options maximumAge = 0 ].
	self assert: [ options timeout = 100 ].
!
