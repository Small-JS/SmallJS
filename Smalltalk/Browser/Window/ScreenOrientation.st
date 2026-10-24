CLASS ScreenOrientation EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: ScreenOrientation."

METHODS

"Properties."

type
	^ String fromJs: INLINE 'this.js.type'.
!
angle
	"Return the orientation angle in degrees: 0, 90, 180 or 270."
	^ Integer fromJs: INLINE 'this.js.angle'.
!

"Methods."

lock: orientation onLocked: block onError: errorBlock
	"The error block is called with an Error argument, e.g. when the document is not fullscreen."
	Error.  "Force import of class."
	INLINE 'this.js.lock( orientation.js )
		.then( () => block.js() )
		.catch( ( error ) => errorBlock.js( stError$class.$fromJs$( error ) ) )'.
!
unlock
	INLINE 'this.js.unlock()'.
!

