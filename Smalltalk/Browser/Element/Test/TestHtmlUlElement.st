CLASS TestHtmlUlElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| list item |
	list := Document default createElement: 'ul'.
	self assert: [ list class = HtmlUlElement ].
	self assert: [ list tagName = 'UL' ].

	item := Document default createElement: 'li'.
	item textContent: 'First'.
	list appendChild: item.
	list appendChild: ( Document default createElement: 'li' ).
	self assert: [ list childElementCount = 2 ].
	self assert: [ list firstElementChild class = HtmlLiElement ].
	self assert: [ list firstElementChild textContent = 'First' ].
!
