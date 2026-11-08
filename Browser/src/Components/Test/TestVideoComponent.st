CLASS TestVideoComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| component video |
	component := MyBrowserApp default findComponent: VideoComponent.
	self assert: [ component playButton textContent = 'Play' ].
	self assert: [ component pauseButton textContent = 'Pause' ].
	self assert: [ component stopButton textContent = 'Stop' ].

	video := component video.
	self assert: [ video class = HtmlVideoElement ].
	self assert: [ video src endsWith: 'flower.mp4' ].
	self assert: [ video size = ( 240 @ 135 ) ].
	self assert: [ video controls ].
	self assert: [ video autoplay not ].
	self assert: [ video preload = 'metadata' ].
!
testGui
	"Only test the playback state, which changes immediately,
	 so the test does not depend on loading the video from the network.
	 Mute the video, because unmuted playback without user interaction is not allowed."
	| component video |
	component := MyBrowserApp default findComponent: VideoComponent.
	video := component video.
	video muted: true.
	self assert: [ video paused ].

	component playButton click.
	self assert: [ video paused not ].

	component pauseButton click.
	self assert: [ video paused ].

	component playButton click.
	self assert: [ video paused not ].

	component stopButton click.
	self assert: [ video paused ].
	self assert: [ video currentTime = 0 ].
	video muted: false.
!
