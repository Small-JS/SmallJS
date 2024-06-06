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
