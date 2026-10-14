CLASS AnimationPlaybackEventOptions EXTENDS EventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating an AnimationPlaybackEvent instance."

METHODS

currentTime
	^ Float fromJs: INLINE 'this.js.currentTime'.
!
currentTime: currentTime
	INLINE 'this.js.currentTime = currentTime.js'.
!
timelineTime
	^ Float fromJs: INLINE 'this.js.timelineTime'.
!
timelineTime: timelineTime
	INLINE 'this.js.timelineTime = timelineTime.js'.
!
