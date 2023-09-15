CLASS TestHtmlTemplateElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| template templateSpan |
	template := Document default getElementById: 'template'.
	self assert: [ template class = HtmlTemplateElement ].

	templateSpan := Document default getElementById: 'templateSpan'.
	self assert: [ templateSpan class = HtmlSpanElement ].

	templateSpan removeChildren.
	templateSpan appendChild: ( template content cloneNode: true ).
	self assert: [ templateSpan firstChild class = Text ].
!
