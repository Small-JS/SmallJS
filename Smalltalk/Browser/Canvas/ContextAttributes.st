CLASS ContextAttributes EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

alpha
	^ Boolean fromJs: INLINE 'this.js.alpha'.
!
colorSpace
	^ String fromJs: INLINE 'this.js.colorSpace'.
!
desynchronized
	^ Boolean fromJs: INLINE 'this.js.desynchronized'.
!
willReadFrequently
	"Chromium browser put a string in this field?"
	^ Boolean fromJs: INLINE 'this.js.willReadFrequently == true'.
!
