CLASS Worker EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new: url
	^ self fromJs: INLINE 'new Worker( url.js )'.
!
new: url options: options
	^ self fromJs: INLINE 'new Worker( url.js, options.js )'.
!

METHODS

postMessage: object
	INLINE 'this.js.postMessage( object.$toJs() )'.
!
terminate
	INLINE 'this.js.terminate()'.
!
onMessage: block
	INLINE 'this.js.onmessage = ( jsMessageEvent ) => block.$value$( stMessageEvent$class.$fromJs$( jsMessageEvent ) )'.
!
