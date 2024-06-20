CLASS TestHtmlTitleElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| document title |
	document := Document new.
	document title: 'My title'.

	title := document querySelector: 'title'.
	self assert: [ title class = HtmlTitleElement ].
	self assert: [ title text = 'My title' ].
	title text: 'New title'.
	self assert: [ title text = 'New title' ].
	self assert: [ document title = 'New title' ].
!
