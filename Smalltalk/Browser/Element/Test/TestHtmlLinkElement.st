CLASS TestHtmlLinkElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| link |
	link := Document new createElement: 'link'.
	self assert: [ link class = HtmlLinkElement ].

	self assert: [ link as = '' ].
	link as: 'style'.
	self assert: [ link as = 'style' ].

	self assert: [ link crossOrigin isNil ].
	link crossOrigin: 'use-credentials'.
	self assert: [ link crossOrigin = 'use-credentials' ].

	self assert: [ link disabled not ].
	link disabled: true.
	self assert: [ link disabled ].

	self assert: [ link href = '' ].
	link href: 'Missing.css'.
	self assert: [ link href endsWith: 'Missing.css' ].

	self assert: [ link hreflang = '' ].
	link hreflang: 'en'.
	self assert: [ link hreflang = 'en' ].

	self assert: [ link media = '' ].
	link media: 'print'.
	self assert: [ link media = 'print' ].

	self assert: [ link referrerPolicy = '' ].
	link referrerPolicy: 'no-referrer'.
	self assert: [ link referrerPolicy = 'no-referrer' ].

	self assert: [ link rel = '' ].
	link rel: 'alternate'.
	self assert: [ link rel = 'alternate' ].
	self assert: [ link relList values first = 'alternate' ].

	self assert: [ link type = '' ].
	link type: 'text/css'.
	self assert: [ link type = 'text/css' ].
!
