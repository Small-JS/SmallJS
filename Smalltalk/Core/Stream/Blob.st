CLASS Blob EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

fromArray: parts
	"Parts is an Array of Strings, typed arrays, ArrayBuffers or Blobs, or a single one of those."
	^ self fromJs: INLINE 'new Blob( this.$jsParts$( parts ) )'.
!
fromArray: parts options: options
	"Options is a BlobCreateOptions instance."
	^ self fromJs: INLINE 'new Blob( this.$jsParts$( parts ), options.js )'.
!
jsParts: parts
	"Private. Returns a JS array of the JS parts.
	 A single part, e.g. a Uint8Array, is wrapped in an array.
	 Otherwise JS would iterate over its bytes and add each byte as a decimal string."
	INLINE '
		let jsParts = parts.$toJs();
		return Array.isArray( jsParts ) ? jsParts : [ jsParts ]'.
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

async arrayBuffer
	^ ArrayBuffer fromJs: INLINE 'await this.js.arrayBuffer()'.
!
arrayBufferThen: block
	INLINE 'this.js.arrayBuffer()
		.then( ( arrayBuffer ) => block.js( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )'.
!
arrayBufferThen: thenBlock catch: catchBlock
	INLINE 'this.js.arrayBuffer()
		.then( ( arrayBuffer ) => thenBlock.js( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) )
		.catch( ( error ) => catchBlock.js( stError$class.$fromJs$( error ) ) )'.
!
async bytes
	^ Uint8Array fromJs: INLINE 'await this.js.bytes()'.
!
bytesThen: block
	INLINE 'this.js.bytes()
		.then( ( bytes ) => block.js( stUint8Array$class.$fromJs$( bytes ) ) )'.
!
bytesThen: thenBlock catch: catchBlock
	INLINE 'this.js.bytes()
		.then( ( bytes ) => thenBlock.js( stUint8Array$class.$fromJs$( bytes ) ) )
		.catch( ( error ) => catchBlock.js( stError$class.$fromJs$( error ) ) )'.
!
slice: from
	^ Blob fromJs: INLINE 'this.js.slice( from.js )'.
!
slice: from to: to
	^ Blob fromJs: INLINE 'this.js.slice( from.js, to.js )'.
!
slice: from to: to type: type
	"Type is the content type of the new Blob."
	^ Blob fromJs: INLINE 'this.js.slice( from.js, to.js, type.js )'.
!
stream
	^ ReadableStream fromJs: INLINE 'this.js.stream()'.
!
async text
	^ String fromJs: INLINE 'await this.js.text()'.
!
textThen: block
	"Convert BLOB to text async."
	INLINE 'this.js.text()
		.then( ( string ) => block.js( stString$class.$fromJs$( string ) ) )'.
!
textThen: thenBlock catch: catchBlock
	INLINE 'this.js.text()
		.then( ( string ) => thenBlock.js( stString$class.$fromJs$( string ) ) )
		.catch( ( error ) => catchBlock.js( stError$class.$fromJs$( error ) ) )'.
!
