CLASS DataTransferItem EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: DataTransferItem, an item of a DataTransferItemList:
 a String or a File."

METHODS

"Properties"

kind
	"Either 'string' or 'file'."
	^ String fromJs: INLINE 'this.js.kind'.
!
type
	"The MIME type, e.g. 'text/plain' or 'image/png'. Can be empty for files."
	^ String fromJs: INLINE 'this.js.type'.
!

"Data"

asFile
	"Answer the File, or nil if the item is not a file."
	^ File fromJs: INLINE 'this.js.getAsFile()'.
!
async asString
	"Answer the String data. Not answered if the item is not a string."
	^ String fromJs: INLINE 'await new Promise( resolve => this.js.getAsString( resolve ) )'.
!
asStringThen: block
	"Call block with the String data. Not called if the item is not a string."
	| jsBlock |
	jsBlock := [ :jsString | block value: ( String fromJs: jsString ) ].
	INLINE 'this.js.getAsString( jsBlock.js )'.
!
