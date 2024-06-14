CLASS TestHtmlElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Test HtmlElement through instances of subclasses."

testProperties
	| paragraph  |
	paragraph := Document new createElement: 'p'.
	self assert: [ paragraph class = HtmlParagraphElement ].

	self assert: [ paragraph accessKey = '' ].
	paragraph accessKey: 'q'.
	self assert: [ paragraph accessKey = 'q' ].

	self assert: [ paragraph dir = '' ].
	paragraph dir: 'ltr'.
	self assert: [ paragraph dir = 'ltr' ].

	self assert: [ paragraph enterKeyHint = '' ].
	paragraph enterKeyHint: 'done'.
	self assert: [ paragraph enterKeyHint = 'done' ].

	self assert: [ paragraph hidden not ].
	paragraph hidden: true.
	self assert: [ paragraph hidden ].

	self assert: [ paragraph inert not ].
	paragraph inert: true.
	self assert: [ paragraph inert ].

	self assert: [ paragraph innerText = '' ].
	paragraph innerText: 'Text'.
	self assert: [ paragraph innerText = 'Text' ].

	self assert: [ paragraph outerText = paragraph innerText ].

	self assert: [ paragraph isContentEditable not ].

	self assert: [ paragraph lang = '' ].
	paragraph lang: 'en'.
	self assert: [ paragraph lang = 'en' ].

	self assert: [ paragraph nonce = '' ].
	paragraph nonce: 'whatever'.
	self assert: [ paragraph nonce = 'whatever' ].
	paragraph nonce: ''.

	self assert: [ paragraph offsetTop = 0 ].
	self assert: [ paragraph offsetLeft = 0 ].
	self assert: [ paragraph offsetHeight = 0 ].
	self assert: [ paragraph offsetWidth = 0 ].

	self assert: [ paragraph style class = CssStyleDeclaration ].

	self assert: [ paragraph tabIndex = -1 ].
	paragraph tabIndex: 0.
	self assert: [ paragraph tabIndex = 0 ].
	paragraph tabIndex: -1.

	self assert: [ paragraph title = '' ].
	paragraph title: 'Title'.
	self assert: [ paragraph title = 'Title' ].
!
testMethods
	| document paragraph  |
	document := Document new.

	"These can only be tested in visible documents:
		paragraph forceFocus.
		paragraph blur."

	"Method click is tested in TestEventTarget."
!
