CLASS TestHtmlScriptElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| script |
	script := Document new createElement: 'script'.
	self assert: [ script class = HtmlScriptElement ].
	self assert: [ HtmlScriptElement supports: 'module' ].

	self assert: [ script type = '' ].
	script type: 'application/javascript'.
	self assert: [ script type = 'application/javascript' ].

	self assert: [ script src endsWith: '' ].
	script src: 'Missing.js'.
	self assert: [ script src endsWith: 'Missing.js' ].

	self assert: [ script isAsync ].
	script isAsync: false.
	self assert: [ script isAsync not ].

	self assert: [ script defer not ].
	script defer: true.
	self assert: [ script defer ].

	self assert: [ script crossOrigin isNil ].
	script crossOrigin: 'anonymous'.
	self assert: [ script crossOrigin = 'anonymous' ].

	self assert: [ script referrerPolicy = '' ].
	script referrerPolicy: 'same-origin'.
	self assert: [ script referrerPolicy = 'same-origin' ].

	self assert: [ script text = '' ].
	script text: 'let n = 1;'.
	self assert: [ script text = 'let n = 1;' ].
!
