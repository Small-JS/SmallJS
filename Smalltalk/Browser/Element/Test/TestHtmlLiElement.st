CLASS TestHtmlLiElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| item |
	item := Document default createElement: 'li'.
	self assert: [ item class = HtmlLiElement ].
	self assert: [ item tagName = 'LI' ].
	self assert: [ item value = 0 ].

	item value: 5.
	self assert: [ item value = 5 ].
	self assert: [ ( item getAttribute: 'value' ) = '5' ].
!
