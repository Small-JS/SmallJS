CLASS HtmlTemplateElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

content
	^ DocumentFragment fromJs: INLINE 'this.js.content'.
!
