CLASS Animation EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: Animation.
 Create one with: Element animate: keyframes options: options,
 or get the running ones with: Element getAnimations.
 Times are Floats in milliseconds, or nil if not set.
 Only time based timelines, like the default document timeline, are supported.
 Times of a JS ScrollTimeline are CSSNumericValues, that are not converted."

CLASSMETHODS

new
	"Create an animation without effect on the document timeline."
	^ self fromJs: INLINE 'new Animation()'.
!

METHODS

"Properties."

currentTime
	^ Float fromJs: INLINE 'this.js.currentTime'.
!
currentTime: currentTime
	INLINE 'this.js.currentTime = currentTime.js'.
!
effect
	"Return the JS AnimationEffect as a JsObject, or nil."
	^ JsObject fromJs: INLINE 'this.js.effect'.
!
effect: effect
	"Effect is a JsObject for a JS AnimationEffect, or nil."
	INLINE 'this.js.effect = effect.js'.
!
id
	^ String fromJs: INLINE 'this.js.id'.
!
id: id
	INLINE 'this.js.id = id.js'.
!
pending
	"True if the animation is waiting for an asynchronous operation, like starting to play."
	^ Boolean fromJs: INLINE 'this.js.pending'.
!
playState
	"Return one of: 'idle' 'running' 'paused' 'finished'."
	^ String fromJs: INLINE 'this.js.playState'.
!
playbackRate
	^ Float fromJs: INLINE 'this.js.playbackRate'.
!
playbackRate: playbackRate
	INLINE 'this.js.playbackRate = playbackRate.js'.
!
replaceState
	"Return one of: 'active' 'persisted' 'removed'."
	^ String fromJs: INLINE 'this.js.replaceState'.
!
startTime
	^ Float fromJs: INLINE 'this.js.startTime'.
!
startTime: startTime
	INLINE 'this.js.startTime = startTime.js'.
!
timeline
	"Return the JS AnimationTimeline as a JsObject, or nil."
	^ JsObject fromJs: INLINE 'this.js.timeline'.
!
timeline: timeline
	"Timeline is a JsObject for a JS AnimationTimeline, or nil."
	INLINE 'this.js.timeline = timeline.js'.
!

"Promises."

async finished
	"Wait until the animation has finished.
	 Throws a JS DOMException named 'AbortError' if the animation is canceled."
	INLINE 'await this.js.finished'.
!
async ready
	"Wait until the animation is ready to play."
	INLINE 'await this.js.ready'.
!

"Methods."

cancel
	INLINE 'this.js.cancel()'.
!
commitStyles
	"Write the current styles of the animation to the style attribute of the target element."
	INLINE 'this.js.commitStyles()'.
!
finish
	INLINE 'this.js.finish()'.
!
pause
	INLINE 'this.js.pause()'.
!
persist
	"Prevent the animation from being removed automatically when it is replaced by another one."
	INLINE 'this.js.persist()'.
!
play
	INLINE 'this.js.play()'.
!
reverse
	INLINE 'this.js.reverse()'.
!
updatePlaybackRate: playbackRate
	"Set the playback rate after synchronizing the playback position."
	INLINE 'this.js.updatePlaybackRate( playbackRate.js )'.
!

"Events."

onCancel: block
	"Block is called with an AnimationPlaybackEvent when the animation is canceled."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( AnimationPlaybackEvent fromJs: jsEvent ) ].
	INLINE 'this.js.oncancel = jsBlock.js'.
!
onFinish: block
	"Block is called with an AnimationPlaybackEvent when the animation finishes."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( AnimationPlaybackEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onfinish = jsBlock.js'.
!
onRemove: block
	"Block is called with an AnimationPlaybackEvent when the animation is removed automatically."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( AnimationPlaybackEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onremove = jsBlock.js'.
!
