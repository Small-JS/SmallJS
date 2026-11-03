CLASS DataTransfer EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: DataTransfer,
 the data of a drag and drop, clipboard or input operation, see: DragEvent and InputEvent.
 It contains items of a type, like 'text/plain' or 'text/uri-list', and files.
 During a drag, the data can only be set in 'dragstart' and only be read in 'drop'."

CLASSMETHODS

"Creating"

new
	"An empty DataTransfer, e.g. for creating events."
	^ self fromJs: INLINE 'new DataTransfer()'.
!

METHODS

"Properties"

dropEffect
	"The effect of the drop: 'none', 'copy', 'link' or 'move'."
	^ String fromJs: INLINE 'this.js.dropEffect'.
!
dropEffect: dropEffect
	"Set in 'dragenter' and 'dragover' to show the user the effect of dropping.
	 Outside of drag events, browsers may ignore this."
	INLINE 'this.js.dropEffect = dropEffect.js'.
!
effectAllowed
	"The allowed effects: 'none', 'copy', 'copyLink', 'copyMove', 'link', 'linkMove', 'move', 'all'
	 or 'uninitialized'."
	^ String fromJs: INLINE 'this.js.effectAllowed'.
!
effectAllowed: effectAllowed
	"Set in 'dragstart'. Elsewhere, browsers ignore this."
	INLINE 'this.js.effectAllowed = effectAllowed.js'.
!
files
	"The Array of Files. Empty if no files are transferred."
	^ Array fromJs: INLINE 'this.js.files' elementClass: File.
!
items
	"The DataTransferItemList, for adding files and access to all items."
	^ DataTransferItemList fromJs: INLINE 'this.js.items'.
!
types
	"The Array of the type Strings of the items, with 'Files' if files are transferred."
	^ Array fromJsStrings: INLINE 'this.js.types'.
!

"Data"

getData: type
	"Answer the String data of type, or an empty String if there is none."
	^ String fromJs: INLINE 'this.js.getData( type.js )'.
!
setData: type value: data
	"Set the String data of type, replacing existing data of that type."
	INLINE 'this.js.setData( type.js, data.js )'.
!
clearData
	"Remove the data of all types. Files are not removed."
	INLINE 'this.js.clearData()'.
!
clearData: type
	INLINE 'this.js.clearData( type.js )'.
!

"Drag image"

setDragImage: element offset: offset
	"Use element as the image under the pointer while dragging, instead of the dragged element.
	 Offset is a Point, the position of the pointer in the image. Call in 'dragstart'."
	INLINE 'this.js.setDragImage( element.js, offset.x.js, offset.y.js )'.
!
