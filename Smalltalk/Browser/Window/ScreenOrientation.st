CLASS ScreenOrientation EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class: Screen."

METHODS

"Properties."

type
	^ String fromJs: INLINE 'this.js.type'.
!
angle
	^ String fromJs: INLINE 'this.js.angle'.
!

"Methods."

lock: orientation onLocked: block onError: errorBlock
	INLINE 'this.js.lock( orientation.js ).then( () => block.js() ).catch( () => errorBlock.js() )'.
!
unlock
	INLINE 'this.js.unlock()'.
!

