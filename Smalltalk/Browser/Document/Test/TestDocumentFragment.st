CLASS TestDocumentFragment EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| documentFragment elementArray |
	documentFragment := DocumentFragment new.

	documentFragment append: ( Document default createElement: 'label' ).
	documentFragment append: ( Document default createElement: 'input' ).
	documentFragment prepend: ( Document default createElement: 'p' ).

	self assert: [ documentFragment childElementCount = 3 ].
	self assert: [ documentFragment firstElementChild class = HtmlParagraphElement ].
	self assert: [ ( documentFragment children at: 1 ) class = HtmlLabelElement ].
	self assert: [ documentFragment lastElementChild class = HtmlInputElement ].

	self assert: [ ( documentFragment querySelector: 'label' ) class = HtmlLabelElement ].
	self assert: [ ( documentFragment querySelectorAll: 'input' ) first class = HtmlInputElement ].

	elementArray := Array with: ( Document default createElement: 'p' ).
	documentFragment replaceChildren: elementArray.
	self assert: [ documentFragment firstElementChild class = HtmlParagraphElement ].
!
