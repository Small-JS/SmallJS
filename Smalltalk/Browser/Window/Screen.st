CLASS Screen EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS class: Screen."

METHODS

"Properties."

availTop
	^ Integer fromJs: INLINE 'this.js.availTop'.
!
availLeft
	^ Integer fromJs: INLINE 'this.js.availLeft'.
!

height
	^ Integer fromJs: INLINE 'this.js.height'.
!
width
	^ Integer fromJs: INLINE 'this.js.width'.
!

availHeight
	^ Integer fromJs: INLINE 'this.js.availHeight'.
!
availWidth
	^ Integer fromJs: INLINE 'this.js.availWidth'.
!

colorDepth
	^ Integer fromJs: INLINE 'this.js.colorDepth'.
!
pixelDepth
	^ Integer fromJs: INLINE 'this.js.pixelDepth'.
!

orientation
	^ ScreenOrientation fromJs: INLINE 'this.js.orientation'.
!

