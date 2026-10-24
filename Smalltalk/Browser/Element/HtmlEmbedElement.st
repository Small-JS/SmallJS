CLASS HtmlEmbedElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLEmbedElement."

METHODS

width
	"A string, like: '300' or '50%'."
	^ String fromJs: INLINE 'this.js.width'.
!
height
	"A string, like: '40' or '50%'."
	^ String fromJs: INLINE 'this.js.height'.
!
size
	"Return the size in pixels as a Point. An empty width or height is 0.
	 Note: Use width and height to get sizes in other units, like percentages."
	^ ( Integer fromJs: INLINE 'this.js.width' ) @ ( Integer fromJs: INLINE 'this.js.height' ).
!
src
	^ String fromJs: INLINE 'this.js.src'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
