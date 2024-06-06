CLASS TestShadowRoot EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| document shadow paragraph  |

	document := Document new.
	shadow := document body shadowRoot.
	shadow isNil ifTrue: [
		shadow := document body attachShadow: 'open' delegatesFocus: false ].
	self assert: [ shadow class = ShadowRoot ].

	"Create test shadow root document."
	paragraph := ( Document default createElement: 'p' ) textContent: 'New paragraph within shadow root'.
	shadow appendChild: paragraph.
	self assert: [ shadow firstElementChild class = HtmlParagraphElement ].

	"Test properties."

	self assert: [ shadow activeElement isNil ].
	self assert: [ shadow adoptedStyleSheets length = 0 ].
	self assert: [ shadow delegatesFocus not ].
	self assert: [ shadow fullscreenElement = nil ].
	self assert: [ shadow host class = HtmlBodyElement ].
	self assert: [ shadow innerHtml startsWith: '<p>' ].
	self assert: [ shadow mode = 'open' ].
	self assert: [ shadow pointerLockElement isNil ].
	self assert: [ shadow styleSheets length = 0 ].

	"Test methods."

	self assert: [ shadow getAnimations length = 0 ].
!
