CLASS AnimationPlaybackEvent EXTENDS Event MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS AnimationPlaybackEvent class.
 Sent to an Animation with type 'cancel', 'finish' or 'remove'.
 Times are Floats in milliseconds, or nil. As in Animation, ScrollTimeline times are not supported."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new AnimationPlaybackEvent( type.js )'.
!
type: type options: options
	"Options is an AnimationPlaybackEventOptions instance."
	^ self fromJs: INLINE 'new AnimationPlaybackEvent( type.js, options.js )'.
!

METHODS

currentTime
	"The current time in milliseconds of the animation that sent the event, or nil."
	^ Float fromJs: INLINE 'this.js.currentTime'.
!
timelineTime
	"The time in milliseconds of the timeline of the animation that sent the event, or nil."
	^ Float fromJs: INLINE 'this.js.timelineTime'.
!
