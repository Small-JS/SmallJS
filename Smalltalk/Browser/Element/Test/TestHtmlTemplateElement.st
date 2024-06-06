CLASS TestHtmlTemplateElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| template templateSpan |
	template := Document getElementById: 'template' class: HtmlTemplateElement.
	templateSpan := Document getElementById: 'templateSpan' class: HtmlSpanElement.

	templateSpan removeChildren.
	templateSpan appendChild: ( template content cloneNode: true ).
	self assert: [ templateSpan firstChild class = Text ].
!
