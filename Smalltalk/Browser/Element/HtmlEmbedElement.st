CLASS HtmlEmbedElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class HTMLEmbedElement,
	 of which variable js contains an instance."

METHODS

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
size
	^ self width @ self height.
!
src
	^ String fromJs: INLINE 'this.js.src'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
