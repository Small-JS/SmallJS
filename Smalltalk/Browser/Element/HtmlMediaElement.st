CLASS HtmlMediaElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLMediaElement.
	 It is the abstract superclass of HtmlAudioElement and HtmlVideoElement.
	 Not implemented: buffered, played and seekable (TimeRanges), error (MediaError),
	 srcObject (MediaStream), the track lists and the properties not supported by all major browsers."

CLASSMETHODS

"Network states."

networkEmpty
	^ Integer fromJs: INLINE 'HTMLMediaElement.NETWORK_EMPTY'.
!
networkIdle
	^ Integer fromJs: INLINE 'HTMLMediaElement.NETWORK_IDLE'.
!
networkLoading
	^ Integer fromJs: INLINE 'HTMLMediaElement.NETWORK_LOADING'.
!
networkNoSource
	^ Integer fromJs: INLINE 'HTMLMediaElement.NETWORK_NO_SOURCE'.
!

"Ready states."

haveNothing
	^ Integer fromJs: INLINE 'HTMLMediaElement.HAVE_NOTHING'.
!
haveMetadata
	^ Integer fromJs: INLINE 'HTMLMediaElement.HAVE_METADATA'.
!
haveCurrentData
	^ Integer fromJs: INLINE 'HTMLMediaElement.HAVE_CURRENT_DATA'.
!
haveFutureData
	^ Integer fromJs: INLINE 'HTMLMediaElement.HAVE_FUTURE_DATA'.
!
haveEnoughData
	^ Integer fromJs: INLINE 'HTMLMediaElement.HAVE_ENOUGH_DATA'.
!

METHODS

"Source"

src
	^ String fromJs: INLINE 'this.js.src'.
!
src: src
	INLINE 'this.js.src = src.js'.
!
currentSrc
	^ String fromJs: INLINE 'this.js.currentSrc'.
!
crossOrigin
	^ String fromJs: INLINE 'this.js.crossOrigin'.
!
crossOrigin: crossOrigin
	INLINE 'this.js.crossOrigin = crossOrigin.js'.
!
preload
	"One of: 'none', 'metadata', 'auto' or ''."
	^ String fromJs: INLINE 'this.js.preload'.
!
preload: preload
	INLINE 'this.js.preload = preload.js'.
!

"Playback options"

autoplay
	^ Boolean fromJs: INLINE 'this.js.autoplay'.
!
autoplay: autoplay
	INLINE 'this.js.autoplay = autoplay.js'.
!
controls
	^ Boolean fromJs: INLINE 'this.js.controls'.
!
controls: controls
	INLINE 'this.js.controls = controls.js'.
!
loop
	^ Boolean fromJs: INLINE 'this.js.loop'.
!
loop: loop
	INLINE 'this.js.loop = loop.js'.
!
defaultPlaybackRate
	^ Float fromJs: INLINE 'this.js.defaultPlaybackRate'.
!
defaultPlaybackRate: rate
	INLINE 'this.js.defaultPlaybackRate = rate.js'.
!
playbackRate
	^ Float fromJs: INLINE 'this.js.playbackRate'.
!
playbackRate: rate
	INLINE 'this.js.playbackRate = rate.js'.
!
preservesPitch
	^ Boolean fromJs: INLINE 'this.js.preservesPitch'.
!
preservesPitch: preservesPitch
	INLINE 'this.js.preservesPitch = preservesPitch.js'.
!

"Volume"

volume
	"A Float between 0 and 1."
	^ Float fromJs: INLINE 'this.js.volume'.
!
volume: volume
	INLINE 'this.js.volume = volume.js'.
!
muted
	^ Boolean fromJs: INLINE 'this.js.muted'.
!
muted: muted
	INLINE 'this.js.muted = muted.js'.
!
defaultMuted
	^ Boolean fromJs: INLINE 'this.js.defaultMuted'.
!
defaultMuted: defaultMuted
	INLINE 'this.js.defaultMuted = defaultMuted.js'.
!

"Playback state, read-only, except currentTime"

currentTime
	"The playback position in seconds."
	^ Float fromJs: INLINE 'this.js.currentTime'.
!
currentTime: seconds
	INLINE 'this.js.currentTime = seconds.js'.
!
duration
	"The length of the media in seconds. NaN if it is not known yet, Infinity for streams."
	^ Float fromJs: INLINE 'this.js.duration'.
!
ended
	^ Boolean fromJs: INLINE 'this.js.ended'.
!
paused
	^ Boolean fromJs: INLINE 'this.js.paused'.
!
seeking
	^ Boolean fromJs: INLINE 'this.js.seeking'.
!
networkState
	"One of the network state constants of the class, like: networkIdle."
	^ Integer fromJs: INLINE 'this.js.networkState'.
!
readyState
	"One of the ready state constants of the class, like: haveMetadata."
	^ Integer fromJs: INLINE 'this.js.readyState'.
!

"Methods"

canPlayType: mimeType
	"Return 'probably', 'maybe' or '' (cannot play)."
	^ String fromJs: INLINE 'this.js.canPlayType( mimeType.js )'.
!
load
	"Reset the element and load the media source again."
	INLINE 'this.js.load()'.
!
async play
	"Start playback. Throws an Error if playback is not possible,
	 e.g. if there is no supported source or autoplay is not allowed."
	INLINE 'await this.js.play()'.
!
pause
	INLINE 'this.js.pause()'.
!

"Events"

onCanPlay: block
	self addEventListener: 'canplay' then: block.
!
onEnded: block
	self addEventListener: 'ended' then: block.
!
onLoadedMetadata: block
	self addEventListener: 'loadedmetadata' then: block.
!
onPause: block
	self addEventListener: 'pause' then: block.
!
onPlay: block
	self addEventListener: 'play' then: block.
!
onSeeked: block
	self addEventListener: 'seeked' then: block.
!
onTimeUpdate: block
	self addEventListener: 'timeupdate' then: block.
!
onVolumeChange: block
	self addEventListener: 'volumechange' then: block.
!
