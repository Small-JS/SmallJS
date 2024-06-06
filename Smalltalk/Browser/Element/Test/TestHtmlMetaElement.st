CLASS TestHtmlMetaElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| meta |
	meta := Document default createElement: 'meta'.
	self assert: [ meta class = HtmlMetaElement ].

	meta charset: 'utf-8'.
	self assert: [ meta charset = 'utf-8' ].

	meta httpEquiv: 'refresh'.
	self assert: [ meta httpEquiv = 'refresh' ].

	meta name: 'theme-color'.
	self assert: [ meta name = 'theme-color' ].

	meta content: '#3c790a'.
	self assert: [ meta content = '#3c790a' ].

	meta media: '(prefers-color-scheme: dark)'.
	self assert: [ meta media = '(prefers-color-scheme: dark)' ].
!
