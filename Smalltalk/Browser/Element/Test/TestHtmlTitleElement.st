CLASS TestHtmlTitleElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| title titleSpan titleText |
	title := Document getElementById: 'title' class: HtmlTitleElement.

	titleText := title text.
	self assert: [ titleText startsWith: 'SmallJS' ].
	title text: 'New document title'.
	self assert: [ title text = 'New document title' ].
	title text: titleText.
!
