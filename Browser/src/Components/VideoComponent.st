CLASS VideoComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'playButton pauseButton stopButton video'

htmlPath
	^ 'Components/VideoComponent.html'.
!
start
	self bindElements.
!
bindElements
	playButton := Document getElementById: 'videoPlayButton' class: HtmlButtonElement.
	playButton onClick: [ self onPlay ].

	pauseButton := Document getElementById: 'videoPauseButton' class: HtmlButtonElement.
	pauseButton onClick: [ self onPause ].

	stopButton := Document getElementById: 'videoStopButton' class: HtmlButtonElement.
	stopButton onClick: [ self onStop ].

	video := Document getElementById: 'video' class: HtmlVideoElement.
!
async onPlay
	"Playing is interrupted with an AbortError if the video is paused before it starts playing."
	await async [ await video play ] tryAwaitCatch: [ :error |
		error name = 'AbortError' ifFalse: [ error throw ] ].
!
onPause
	video pause.
!
onStop
	"Pause the video and return to the start."
	video pause.
	video currentTime: 0.
!

"Accessing"

playButton
	^ playButton.
!
pauseButton
	^ pauseButton.
!
stopButton
	^ stopButton.
!
video
	^ video.
!
