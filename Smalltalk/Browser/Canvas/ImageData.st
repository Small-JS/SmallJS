CLASS ImageData EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

data
	^ Uint8Array fromJs: INLINE 'this.js.data'.
!
colorSpace
	^ String fromJs: INLINE 'this.js.colorSpace'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
width
	^ Integer fromJs: INLINE 'this.js.width'.
!
dimensions
	^ self width @ self height.
!
