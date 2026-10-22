CLASS TestAnimation EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Animations are not run in real time, because the timeline may not advance
 if the browser window is hidden. The playback position is set explicitly instead."

METHODS

"Helpers."

createElement
	| element |
	element := Document default createElement: 'div'.
	Document default body appendChild: element.
	^ element.
!
keyframes
	"Return keyframes that animate the opacity from 0 to 1."
	| keyframes |
	keyframes := Array new.
	keyframes add: ( JsObject newEmpty atJsProperty: 'opacity' put: 0 ).
	keyframes add: ( JsObject newEmpty atJsProperty: 'opacity' put: 1 ).
	^ keyframes.
!

"Tests."

testNew
	| animation |
	animation := Animation new.
	self assert: [ animation class = Animation ].
	self assert: [ animation effect isNil ].
	self assert: [ animation timeline notNil ].
	self assert: [ animation playState = 'idle' ].
	self assert: [ animation replaceState = 'active' ].
	self assert: [ animation pending not ].
	self assert: [ animation currentTime isNil ].
	self assert: [ animation startTime isNil ].
	self assert: [ animation playbackRate = 1 ].

	self assert: [ animation id = '' ].
	animation id: 'testAnimation'.
	self assert: [ animation id = 'testAnimation' ].

	animation timeline: nil.
	self assert: [ animation timeline isNil ].
!
testAnimate
	| element animation |
	element := self createElement.
	animation := element animate: self keyframes options: 1000.
	self assert: [ animation class = Animation ].
	self assert: [ animation effect notNil ].
	self assert: [ animation playState = 'running' ].
	self assert: [ element getAnimations length = 1 ].
	self assert: [ element getAnimations first = animation ].

	animation pause.
	self assert: [ animation playState = 'paused' ].
	animation currentTime: 500.
	self assert: [ animation currentTime = 500 ].

	animation playbackRate: 2.
	self assert: [ animation playbackRate = 2 ].
	animation updatePlaybackRate: 1.

	animation play.
	self assert: [ animation playState = 'running' ].
	animation reverse.
	self assert: [ animation playState = 'running' ].

	animation finish.
	self assert: [ animation playState = 'finished' ].

	animation cancel.
	self assert: [ animation playState = 'idle' ].
	self assert: [ animation currentTime isNil ].
	self assert: [ element getAnimations length = 0 ].
	element remove.
!
testOptions
	| element options animation |
	element := self createElement.
	options := JsObject newEmpty.
	options atJsProperty: 'duration' put: 1000.
	options atJsProperty: 'id' put: 'optionsAnimation'.
	animation := element animate: self keyframes options: options.
	self assert: [ animation id = 'optionsAnimation' ].
	animation cancel.
	element remove.
!
testStartTime
	| element animation |
	element := self createElement.
	animation := element animate: self keyframes options: 1000.
	animation startTime: 0.
	self assert: [ animation startTime = 0 ].
	self assert: [ animation pending not ].
	animation cancel.
	element remove.
!
testCommitStyles
	| element animation |
	element := self createElement.
	animation := element animate: self keyframes options: 1000.
	animation pause.
	animation currentTime: 500.
	animation commitStyles.
	self assert: [ ( element getAttribute: 'style' ) includes: 'opacity: 0.5' ].
	animation cancel.
	element remove.
!
testPersist
	| element animation |
	element := self createElement.
	animation := element animate: self keyframes options: 1000.
	self assert: [ animation replaceState = 'active' ].
	animation persist.
	self assert: [ animation replaceState = 'persisted' ].
	animation cancel.
	element remove.
!
async testPromises
	| element animation |
	element := self createElement.
	animation := element animate: self keyframes options: 1000.
	await animation ready.
	self assert: [ animation pending not ].
	animation finish.
	await animation finished.
	self assert: [ animation playState = 'finished' ].
	animation cancel.
	element remove.
!
testEvents
	"Real playback events are sent asynchronously,
	 so only test that listeners can be set and that dispatching works."
	| animation received listened |
	animation := Animation new.

	animation onFinish: [ :event | received := event ].
	animation dispatchEvent: ( AnimationPlaybackEvent type: 'finish' ).
	self assert: [ received class = AnimationPlaybackEvent ].
	self assert: [ received type = 'finish' ].

	animation onCancel: [ :event | received := event ].
	animation dispatchEvent: ( AnimationPlaybackEvent type: 'cancel' ).
	self assert: [ received type = 'cancel' ].

	animation onRemove: [ :event | received := event ].
	animation dispatchEvent: ( AnimationPlaybackEvent type: 'remove' ).
	self assert: [ received type = 'remove' ].

	"Use a separate var, because the onFinish block above also receives this event."
	animation addEventListener: 'finish' then: [ :event | listened := event ].
	animation dispatchEvent: ( Event type: 'finish' ).
	self assert: [ listened type = 'finish' ].
!
