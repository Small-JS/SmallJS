CLASS TestHtmlTitleElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| title titleSpan titleText |
	title := Document default getElementById: 'title'.
	self assert: [ title class = HtmlTitleElement ].

	titleText := title text.
	self assert: [ titleText startsWith: 'SmallJS' ].
	title text: 'New document title'.
	self assert: [ title text = 'New document title' ].
	title text: titleText.
!
