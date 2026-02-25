CLASS TestAnchorComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| anchor |
	anchor := Document getElementById: 'anchor' class: HtmlAnchorElement.

	self assert: [ anchor download = '' ].
	self assert: [ anchor host includes: ':' ].
	self assert: [ anchor hostname length > 0 ].
	self assert: [ anchor href endsWith: 'SmallJS.png' ].
	self assert: [ anchor pathname = '/SmallJS.png' ].
	self assert: [ anchor hreflang = 'en' ].
	self assert: [ Document default documentUri startsWith: anchor origin ].
	self assert: [ anchor referrerPolicy = 'origin' ].
	self assert: [ anchor target = '_blank' ].
	self assert: [ anchor type = 'image/png' ].
!

"No GUI tests, because cannot control newly opened tab easily."
