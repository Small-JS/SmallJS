CLASS HtmlTemplateElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

content
	^ DocumentFragment fromJs: INLINE 'this.js.content'.
!
cloneContent
	"Return a deep clone of the template's content as a DocumentFragment."
	^ self content cloneNode: true.
!
