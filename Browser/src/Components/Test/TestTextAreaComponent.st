CLASS TestTextAreaComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| textAreaComponent textArea |
	textAreaComponent := MyBrowserApp default findComponent: TextAreaComponent.
 	textArea := textAreaComponent textArea.

	self assert: [ textArea placeholder = 'Enter text here...' ].
	self assert: [ textArea rows = 2 ].
	self assert: [ textArea cols = 20 ].
	self assert: [ textArea minLength = 1 ].
	self assert: [ textArea maxLength = 100 ].
	self assert: [ textArea wrap = 'soft' ].
	self assert: [ textArea value = 'aa\nbb' ].
!
testGui
	| textAreaComponent |
	textAreaComponent := MyBrowserApp default findComponent: TextAreaComponent.

	textAreaComponent textArea value: 'cc\ndd'.
	textAreaComponent outputButton click.
	Timer timeout: 500 then: [
		self assert: [ textAreaComponent outputParagraph textContent = 'cc\ndd' ] ].
!
