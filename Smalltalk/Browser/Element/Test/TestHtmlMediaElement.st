CLASS TestHtmlMediaElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"HtmlMediaElement is abstract, so it is tested with a video element,
 because Chrome only allows muted playback without user interaction for video elements.
 The media is a generated WAV sound of silence, so no media file is needed.
 A video element can also play sound only.
 Also used by TestHtmlAudioElement."

CLASSMETHODS

silenceUrl
	"Return a data URL of a WAV sound of 0.5 seconds of silence: 8 kHz, mono, 8 bits."
	^ String fromJs: INLINE '( () => {
		const sampleCount = 4000;
		const bytes = new Uint8Array( 44 + sampleCount );
		const view = new DataView( bytes.buffer );
		const writeText = ( offset, text ) => {
			for( let i = 0; i < text.length; i++ ) bytes[ offset + i ] = text.charCodeAt( i ) };
		writeText( 0, "RIFF" );
		view.setUint32( 4, 36 + sampleCount, true );
		writeText( 8, "WAVEfmt " );
		view.setUint32( 16, 16, true );			// Format chunk size
		view.setUint16( 20, 1, true );			// PCM
		view.setUint16( 22, 1, true );			// Mono
		view.setUint32( 24, 8000, true );		// Sample rate
		view.setUint32( 28, 8000, true );		// Byte rate
		view.setUint16( 32, 1, true );			// Block align
		view.setUint16( 34, 8, true );			// Bits per sample
		writeText( 36, "data" );
		view.setUint32( 40, sampleCount, true );
		bytes.fill( 128, 44 );					// Silence for unsigned 8 bit samples
		return "data:audio/wav;base64," + btoa( String.fromCharCode( ...bytes ) ) } )()'.
!

METHODS

"Helpers."

newMedia
	"Return a muted media element with the silence loaded,
	 so it can play without user interaction."
	| media |
	media := Document default createElement: 'video'.
	media muted: true.
	media src: self class silenceUrl.
	^ media.
!
event: type of: media
	"Return a JS promise that resolves with the event of the given type,
	 or rejects if the media cannot be loaded."
	^ ( Promise new: [ :resolve :reject |
		media addEventListener: type then: [ :event | resolve value: event ].
		media addEventListener: 'error' then: [ :event | reject value: 'Media error' ] ] ) js.
!

"Tests."

testConstants
	self assert: [ HtmlMediaElement networkEmpty = 0 ].
	self assert: [ HtmlMediaElement networkIdle = 1 ].
	self assert: [ HtmlMediaElement networkLoading = 2 ].
	self assert: [ HtmlMediaElement networkNoSource = 3 ].
	self assert: [ HtmlMediaElement haveNothing = 0 ].
	self assert: [ HtmlMediaElement haveMetadata = 1 ].
	self assert: [ HtmlMediaElement haveCurrentData = 2 ].
	self assert: [ HtmlMediaElement haveFutureData = 3 ].
	self assert: [ HtmlMediaElement haveEnoughData = 4 ].
!
testProperties
	| media |
	media := Document default createElement: 'video'.

	self assert: [ media src = '' ].
	media src: 'Missing.mp4'.
	self assert: [ media src endsWith: 'Missing.mp4' ].

	self assert: [ media crossOrigin isNil ].
	media crossOrigin: 'anonymous'.
	self assert: [ media crossOrigin = 'anonymous' ].

	media preload: 'none'.
	self assert: [ media preload = 'none' ].

	self assert: [ media autoplay not ].
	media autoplay: true.
	self assert: [ media autoplay ].

	self assert: [ media controls not ].
	media controls: true.
	self assert: [ media controls ].

	self assert: [ media loop not ].
	media loop: true.
	self assert: [ media loop ].

	self assert: [ media defaultPlaybackRate = 1 ].
	media defaultPlaybackRate: 1.5.
	self assert: [ media defaultPlaybackRate = 1.5 ].

	self assert: [ media playbackRate = 1 ].
	media playbackRate: 2.
	self assert: [ media playbackRate = 2 ].

	self assert: [ media preservesPitch ].
	media preservesPitch: false.
	self assert: [ media preservesPitch not ].

	self assert: [ media volume = 1 ].
	media volume: 0.5.
	self assert: [ media volume = 0.5 ].

	self assert: [ media muted not ].
	media muted: true.
	self assert: [ media muted ].

	self assert: [ media defaultMuted not ].
	media defaultMuted: true.
	self assert: [ media defaultMuted ].
	self assert: [ media hasAttribute: 'muted' ].
!
testInitialState
	| media |
	media := Document default createElement: 'video'.
	self assert: [ media currentSrc = '' ].
	self assert: [ media currentTime = 0 ].
	self assert: [ media duration isNan ].
	self assert: [ media ended not ].
	self assert: [ media paused ].
	self assert: [ media seeking not ].
	self assert: [ media networkState = HtmlMediaElement networkEmpty ].
	self assert: [ media readyState = HtmlMediaElement haveNothing ].
!
testCanPlayType
	| media |
	media := Document default createElement: 'video'.
	self assert: [ ( media canPlayType: 'audio/wav' ) isEmpty not ].
	self assert: [ ( media canPlayType: 'video/x-unknown' ) = '' ].
!
async testLoad
	| media |
	media := self newMedia.
	await self event: 'loadedmetadata' of: media.
	self assert: [ media currentSrc startsWith: 'data:audio/wav' ].
	self assert: [ media readyState >= HtmlMediaElement haveMetadata ].
	self assert: [ media duration equals: 0.5 precision: 0.01 ].
	self assert: [ media videoSize = ( 0 @ 0 ) ].

	"Seeking."
	media currentTime: 0.25.
	await self event: 'seeked' of: media.
	self assert: [ media currentTime equals: 0.25 precision: 0.01 ].

	"Loading again resets the playback position."
	media load.
	self assert: [ media currentTime = 0 ].
	await self event: 'loadedmetadata' of: media.
!
async testPlay
	| media playing ending |
	media := self newMedia.
	playing := self event: 'play' of: media.
	ending := self event: 'ended' of: media.
	await media play.
	await playing.
	self assert: [ media paused not ].
	await ending.
	self assert: [ media ended ].
	self assert: [ media paused ].
	self assert: [ media currentTime equals: 0.5 precision: 0.01 ].
!
async testPause
	| media pausing |
	media := self newMedia.
	await media play.
	pausing := self event: 'pause' of: media.
	media pause.
	await pausing.
	self assert: [ media paused ].
	self assert: [ media ended not ].
!
async testPlayError
	| media result |
	"Mute, because unmuted playback without user interaction fails with a NotAllowedError."
	media := Document default createElement: 'video'.
	media muted: true.
	media src: 'Missing.mp4'.
	result := await async [ await media play ] tryAwaitCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'NotSupportedError' ].
!
testEvents
	"Real media events are sent asynchronously,
	 so only test that listeners can be set and that dispatching works."
	| media received |
	media := Document default createElement: 'video'.
	media onCanPlay: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'canplay' ).
	self assert: [ received type = 'canplay' ].
	media onEnded: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'ended' ).
	self assert: [ received type = 'ended' ].
	media onLoadedMetadata: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'loadedmetadata' ).
	self assert: [ received type = 'loadedmetadata' ].
	media onPause: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'pause' ).
	self assert: [ received type = 'pause' ].
	media onPlay: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'play' ).
	self assert: [ received type = 'play' ].
	media onSeeked: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'seeked' ).
	self assert: [ received type = 'seeked' ].
	media onTimeUpdate: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'timeupdate' ).
	self assert: [ received type = 'timeupdate' ].
	media onVolumeChange: [ :event | received := event ].
	media dispatchEvent: ( Event type: 'volumechange' ).
	self assert: [ received type = 'volumechange' ].
!
