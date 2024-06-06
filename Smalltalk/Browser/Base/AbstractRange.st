CLASS AbstractRange EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class AbstractRange."

METHODS

"Properties."

collapsed
	^ Boolean fromJs: INLINE 'this.js.collapsed'.
!
startContainer
	^ Node fromJsSubNode: INLINE 'this.js.startContainer'.
!
endContainer
	^ Node fromJsSubNode: INLINE 'this.js.endContainer'.
!
startOffset
	^ Integer fromJs: INLINE 'this.js.startOffset'.
!
endOffset
	^ Integer fromJs: INLINE 'this.js.endOffset'.
!

