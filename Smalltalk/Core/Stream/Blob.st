CLASS Blob EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

fromArray: array
	^ Blob fromJs: INLINE 'new Blob( array.js )'
!

METHODS

"Properties"

size
	^ Integer fromJs: INLINE 'this.js.size'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!

"Methods"

arrayBufferThen: block
	^ ArrayBuffer fromJs: INLINE 'this.js.arrayBuffer()
		.then( ( arrayBuffer ) => block.js( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )'.
!
slice: from to: to
	^ Blob fromJs: INLINE 'this.js.slice( from.js, to.js )'.
!
stream
	^ ReadableStream fromJs: INLINE 'this.js.stream()'.
!
textThen: block
	"Convert BLOB to text async."
	INLINE 'this.js.text()
		.then( ( string ) => block.js( stString$class.$fromJs$( string ) ) )'.
!
