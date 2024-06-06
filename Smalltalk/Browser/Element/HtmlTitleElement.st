CLASS HtmlTitleElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

text
	^ String fromJs: INLINE 'this.js.text'.
!
text: text
	INLINE 'this.js.text = text.js'.
!
