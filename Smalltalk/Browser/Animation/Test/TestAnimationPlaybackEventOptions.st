CLASS TestAnimationPlaybackEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := AnimationPlaybackEventOptions new.
	self assert: [ options class = AnimationPlaybackEventOptions ].
	self assert: [ options currentTime isNil ].
	self assert: [ options timelineTime isNil ].

	options currentTime: 100.
	self assert: [ options currentTime = 100 ].
	options timelineTime: 200.
	self assert: [ options timelineTime = 200 ].

	options := AnimationPlaybackEventOptions new currentTime: 1.5; timelineTime: 2.5; cancelable: true.
	self assert: [ options currentTime = 1.5 ].
	self assert: [ options timelineTime = 2.5 ].
	self assert: [ options cancelable ].
!
