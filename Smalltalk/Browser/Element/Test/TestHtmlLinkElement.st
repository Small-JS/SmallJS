CLASS TestHtmlLinkElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| link |
	link := Document default getElementById: 'link'.
	self assert: [ link class = HtmlLinkElement ].

	self assert: [ link as = '' ].
	link as: 'style'.
	self assert: [ link as = 'style' ].
	link as: ''.

	self assert: [ link crossOrigin = 'anonymous' ].
	link crossOrigin: 'use-credentials'.
	self assert: [ link crossOrigin = 'use-credentials' ].
	link crossOrigin: 'anonymous'.

	self assert: [ link disabled not ].
	link disabled: true.
	self assert: [ link disabled ].
	link disabled: false.

	self assert: [ link href endsWith: 'Linked.css' ].
	link href: 'Test/Missing.css'.
	self assert: [ link href endsWith: 'Test/Missing.css' ].
	link href: 'Test/Linked.css'.

	self assert: [ link hreflang = 'en' ].
	link hreflang: 'nl'.
	self assert: [ link hreflang = 'nl' ].
	link hreflang: 'en'.

	self assert: [ link media = '' ].
	link media: 'print'.
	self assert: [ link media = 'print' ].
	link media: ''.

	self assert: [ link referrerPolicy = 'origin' ].
	link referrerPolicy: 'no-referrer'.
	self assert: [ link referrerPolicy = 'no-referrer' ].
	link referrerPolicy: 'origin'.

	self assert: [ link rel = 'stylesheet' ].
	link rel: 'alternate'.
	self assert: [ link rel = 'alternate' ].
	link rel: 'stylesheet'.

	self assert: [ link relList values first = 'stylesheet' ].
	"The attribute sheet only works for the CSS link in the header."
	self assert: [ ( Document default getElementById: 'stylesheet' ) sheet class = CssStyleSheet ].

	self assert: [ link type = 'text/css' ].
	link type: 'alternate'.
	self assert: [ link type = 'alternate' ].
	link type: 'text/css'.
!
