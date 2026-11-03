CLASS InputEventOptions EXTENDS UiEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating an InputEvent instance."

METHODS

data
	^ String fromJs: INLINE 'this.js.data'.
!
data: data
	INLINE 'this.js.data = data.js'.
!
dataTransfer
	^ DataTransfer fromJs: INLINE 'this.js.dataTransfer'.
!
dataTransfer: dataTransfer
	INLINE 'this.js.dataTransfer = dataTransfer.js'.
!
inputType
	^ String fromJs: INLINE 'this.js.inputType'.
!
inputType: inputType
	INLINE 'this.js.inputType = inputType.js'.
!
isComposing
	^ Boolean fromJs: INLINE 'this.js.isComposing'.
!
isComposing: isComposing
	INLINE 'this.js.isComposing = isComposing.js'.
!
