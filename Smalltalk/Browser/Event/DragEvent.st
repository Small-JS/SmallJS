CLASS DragEvent EXTENDS MouseEvent MODULE Browser CLASSVARS '' VARS ''
	"Encapsulates the JS DragEvent class:
	 sent with types like 'dragstart', 'dragover' and 'drop' during drag and drop.
	 Elements are draggable with the attribute: draggable='true'.
	 To allow dropping on an element, call preventDefault in its 'dragover' listener."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new DragEvent( type.js )'.
!
type: type options: options
	"Options is a DragEventOptions instance."
	^ self fromJs: INLINE 'new DragEvent( type.js, options.js )'.
!

METHODS

"Properties"

dataTransfer
	"The DataTransfer with the dragged data, or nil."
	^ DataTransfer fromJs: INLINE 'this.js.dataTransfer'.
!
