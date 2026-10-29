CLASS QMovie EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"An animation from a GIF or WebP file, shown with QLabel setMovie:.
 Frame numbers start at 0."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QMovie()'.
!
new: fileName
	| movie |
	movie := self new.
	movie setFileName: fileName.
	^ movie.
!

"State enums"

notRunning
	^ 0.
!
paused
	^ 1.
!
running
	^ 2.
!

"Cache mode enums"

cacheNone
	^ 0.
!
cacheAll
	"Cache all frames, needed to jump to any frame. Set it before the file name."
	^ 1.
!

METHODS

"File"

setFileName: fileName
	INLINE 'this.js.setFileName( fileName.js )'.
!
fileName
	^ String fromJs: INLINE 'this.js.fileName()'.
!
format
	"Answer the format, e.g. 'gif', or an empty string if it is not known yet."
	^ String fromJs: INLINE 'this.js.format()'.
!

"Playing"

start
	INLINE 'this.js.start()'.
!
stop
	INLINE 'this.js.stop()'.
!
setPaused: paused
	INLINE 'this.js.setPaused( paused.js )'.
!
state
	"Answer a state enum."
	^ Integer fromJs: INLINE 'this.js.state()'.
!
setSpeed: percentSpeed
	"Speed in percent of the original speed, e.g. 200 is twice as fast."
	INLINE 'this.js.setSpeed( percentSpeed.js )'.
!
speed
	^ Integer fromJs: INLINE 'this.js.property( "speed" ).toInt()'.
!
setScaledSize: size
	INLINE 'this.js.setScaledSize( size.js )'.
!
setCacheMode: cacheMode
	INLINE 'this.js.setCacheMode( cacheMode.js )'.
!

"Frames"

frameCount
	"Answer -1 if the number of frames is not known, e.g. when there is no file."
	^ Integer fromJs: INLINE 'this.js.frameCount()'.
!
currentFrameNumber
	"Answer -1 if there is no current frame."
	^ Integer fromJs: INLINE 'this.js.currentFrameNumber()'.
!
jumpToFrame: frameNumber
	"Answer true if successful. Only the next frame can be jumped to, unless the cache mode is cacheAll."
	^ Boolean fromJs: INLINE 'this.js.jumpToFrame( frameNumber.js )'.
!
jumpToNextFrame
	"Answer true if successful."
	^ Boolean fromJs: INLINE 'this.js.jumpToNextFrame()'.
!

"Events"

onStart: block
	self addEventListener: 'started' then: [ block value ].
!
onFinish: block
	self addEventListener: 'finished' then: [ block value ].
!
onFrameChange: block
	self addEventListener: 'frameChanged' then: [ block value ].
!
onStateChange: block
	self addEventListener: 'stateChanged' then: [ block value ].
!
onError: block
	"Block is called when the file cannot be read."
	self addEventListener: 'error' then: [ block value ].
!
