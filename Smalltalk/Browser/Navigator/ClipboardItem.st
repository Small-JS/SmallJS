CLASS ClipboardItem EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: ClipboardItem.
 It holds the data of one clipboard item in one or more representations,
 each with its own MIME type, e.g. 'text/plain' and 'text/html'.
 Data of a representation is a String or a Blob."

CLASSMETHODS

"Creating"

type: type data: data
	"Create an item with one representation."
	^ self fromJs: INLINE '( () => {
		let jsData = {};
		jsData[ type.js ] = data.$toJs();
		return new ClipboardItem( jsData ); } )()'.
!
types: types data: datas
	"Create an item with multiple representations.
	 Types is an Array of MIME type Strings, datas an Array of Strings or Blobs of the same size."
	^ self fromJs: INLINE '( () => {
		let jsData = {};
		types.js.forEach( ( type, index ) => jsData[ type.js ] = datas.js[ index ].$toJs() );
		return new ClipboardItem( jsData ); } )()'.
!

"Testing"

supports: type
	"Return true if the MIME type is supported by the clipboard."
	^ Boolean fromJs: INLINE 'ClipboardItem.supports( type.js )'.
!

METHODS

"Properties"

presentationStyle
	"Return 'unspecified', 'inline' or 'attachment'. Not supported in Chrome: returns nil."
	^ String fromJs: INLINE 'this.js.presentationStyle'.
!
types
	"Return the MIME types of the representations as an Array of Strings."
	^ Array fromJsStrings: INLINE 'Array.from( this.js.types )'.
!

"Methods"

async getType: type
	"Return the data of the representation with the MIME type as a Blob.
	 Throws a NotFoundError if the type is not present."
	^ Blob fromJs: INLINE 'await this.js.getType( type.js )'.
!
