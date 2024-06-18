CLASS TestHtmlTemplateElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| document template span |
	document := Document new.

	template := document createElement: 'template'.
	self assert: [ template class = HtmlTemplateElement ].
	template content appendChild: ( document createTextNode: 'Template text' ).

	span := document createElement: 'span'.
	self assert: [ span class = HtmlSpanElement ].

	span appendChild: ( template content cloneNode: true ).
	self assert: [ span firstChild textContent = 'Template text' ].
!
