CLASS TestHtmlLabelElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| label  |
	label := Document new createElement: 'label'.
	self assert: [ label class = HtmlLabelElement ].

	self assert: [ label control isNil ].
	self assert: [ label form isNil ].

	self assert: [ label htmlFor = '' ].
	label htmlFor: 'someId'.
	self assert: [ label htmlFor = 'someId' ].
!
testForm
	| form label |
	form := Document new createElement: 'form'.
	"The form of a label is the form of its control."
	form innerHtml: '<label>Label <input></label>'.
	label := form firstElementChild.
	self assert: [ label class = HtmlLabelElement ].
	self assert: [ label control class = HtmlInputElement ].
	self assert: [ label form = form ].
!
