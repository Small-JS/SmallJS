CLASS TestAnimationPlaybackEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := AnimationPlaybackEvent type: 'finish'.
	self assert: [ event class = AnimationPlaybackEvent ].
	self assert: [ event type = 'finish' ].
	self assert: [ event currentTime isNil ].
	self assert: [ event timelineTime isNil ].
!
testOptions
	| event options |
	options := AnimationPlaybackEventOptions new currentTime: 100; timelineTime: 200; bubbles: true.
	event := AnimationPlaybackEvent type: 'cancel' options: options.
	self assert: [ event class = AnimationPlaybackEvent ].
	self assert: [ event type = 'cancel' ].
	self assert: [ event currentTime = 100 ].
	self assert: [ event timelineTime = 200 ].
	self assert: [ event bubbles ].
!
