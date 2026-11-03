CLASS DataTransferItemList EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: DataTransferItemList, the items of a DataTransfer.
 Changing the list changes the DataTransfer."

METHODS

"Accessing"

length
	^ Integer fromJs: INLINE 'this.js.length'.
!
at: index
	"Answer the DataTransferItem at index, starting at 0, or nil."
	^ DataTransferItem fromJs: INLINE 'this.js[ index.js ]'.
!
toArray
	"Answer an Array of the DataTransferItems."
	^ Array fromJs: INLINE 'Array.from( this.js )' elementClass: DataTransferItem.
!

"Changing"

add: data type: type
	"Add String data of type. Answer the new DataTransferItem.
	 Throws a JS DOMException named 'NotSupportedError' if there already is data of type."
	^ DataTransferItem fromJs: INLINE 'this.js.add( data.js, type.js )'.
!
addFile: file
	"Add a File. Answer the new DataTransferItem."
	^ DataTransferItem fromJs: INLINE 'this.js.add( file.js )'.
!
remove: index
	INLINE 'this.js.remove( index.js )'.
!
clear
	INLINE 'this.js.clear()'.
!
