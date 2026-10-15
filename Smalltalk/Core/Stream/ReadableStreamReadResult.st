CLASS ReadableStreamReadResult EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

"Encapsulates the JS object returned by ReadableStreamDefaultReader.read()."

METHODS

done
	^ Boolean fromJs: INLINE 'this.js.done'.
!
value
	"The chunk read, e.g. a Uint8Array for a byte stream. Nil when done."
	^ Object fromJs: INLINE 'this.js.value'.
!
