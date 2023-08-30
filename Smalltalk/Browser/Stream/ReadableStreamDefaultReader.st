CLASS ReadableStreamDefaultReader EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''

METHODS

"Properties"

closedThen: block
	^ Boolean fromJs: INLINE 'this.js.closed().then( block.js )'.
!

"Methods"

cancelThen: block
	INLINE 'this.js.cancel().then( block.js )'.
!
readThen: block
	"Block should have 2 arguments: value (Arraybuffer) and done (Boolean)."
	INLINE 'this.js.read().then(
		( { value, done } ) => block.js( stArrayBuffer.$fromJs$( value ), stBoolean$class.$fromJs$( done ) ) )'.
!
