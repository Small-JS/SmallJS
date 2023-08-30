CLASS HtmlLabelElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

METHODS

control
	^ HtmlElement fromJsSubElement: INLINE 'this.js.control'.
!
form
	^ HtmlFormElement fromJs: INLINE 'this.js.htmlForm'.
!
htmlFor
	^ String fromJs: INLINE 'this.js.htmlFor'.
!
htmlFor: htmlFor
	INLINE 'this.js.htmlFor = htmlFor.js'.
!
