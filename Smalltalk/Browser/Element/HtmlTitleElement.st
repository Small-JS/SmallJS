CLASS HtmlTitleElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

METHODS

text
	^ String fromJs: INLINE 'this.js.text'.
!
text: text
	INLINE 'this.js.text = text.js'.
!
