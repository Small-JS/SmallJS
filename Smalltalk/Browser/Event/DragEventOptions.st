CLASS DragEventOptions EXTENDS MouseEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a DragEvent instance."

METHODS

dataTransfer
	^ DataTransfer fromJs: INLINE 'this.js.dataTransfer'.
!
dataTransfer: dataTransfer
	INLINE 'this.js.dataTransfer = dataTransfer.js'.
!
