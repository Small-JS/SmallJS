CLASS ImageData EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Data"

data
	^ Uint8Array fromJs: INLINE 'this.js.data'.
!

"Dimensions"

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
extent
	^ self width @ self height.
!
