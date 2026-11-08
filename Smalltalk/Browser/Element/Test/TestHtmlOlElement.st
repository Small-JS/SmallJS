CLASS TestHtmlOlElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| list item |
	list := Document default createElement: 'ol'.
	self assert: [ list class = HtmlOlElement ].
	self assert: [ list tagName = 'OL' ].

	self assert: [ list reversed not ].
	list reversed: true.
	self assert: [ list reversed ].
	self assert: [ list hasAttribute: 'reversed' ].

	self assert: [ list start = 1 ].
	list start: 5.
	self assert: [ list start = 5 ].
	self assert: [ ( list getAttribute: 'start' ) = '5' ].

	self assert: [ list type = '' ].
	list type: 'a'.
	self assert: [ list type = 'a' ].

	item := Document default createElement: 'li'.
	list appendChild: item.
	self assert: [ list firstElementChild class = HtmlLiElement ].
!
