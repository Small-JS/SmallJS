CLASS TestHtmlScriptElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
test
	| script |

	self assert: [ HtmlScriptElement supports: 'module' ].

	script := Document default getElementById: 'script'.
	self assert: [ script class = HtmlScriptElement ].

	self assert: [ script type = 'application/javascript' ].
	script type: 'application/ecmascript'.
	self assert: [ script type = 'application/ecmascript' ].
	script type: 'application/javascript'.

	self assert: [ script src endsWith: 'ScriptFunction.js' ].
	script src: 'Missing.js'.
	self assert: [ script src endsWith: 'Missing.js' ].
	script src: 'ScriptFunction.js'.

	self assert: [ script isAsync not ].
	script isAsync: true.
	self assert: [ script isAsync ].
	script isAsync: false.

	self assert: [ script defer not ].
	script defer: true.
	self assert: [ script defer ].
	script defer: false.

	self assert: [ script crossOrigin = 'anonymous' ].
	script crossOrigin: 'use-credentials'.
	self assert: [ script crossOrigin = 'use-credentials' ].
	script crossOrigin: 'anonymous'.

	self assert: [ script referrerPolicy = 'same-origin' ].
	script referrerPolicy: 'origin'.
	self assert: [ script referrerPolicy = 'origin' ].
	script referrerPolicy: 'same-origin'.

	self assert: [ script text = '' ].
	script text: 'let n = 1;'.
	self assert: [ script text = 'let n = 1;' ].
	script text: ''.
!
testButton
	| scriptButton |
	scriptButton := Document default getElementById: 'scriptButton'.
	scriptButton onClick: [ INLINE 'ScriptFunction()' ].
	scriptButton click.
!
