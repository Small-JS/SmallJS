CLASS TestShadowRoot EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

METHODS

test
	| span shadow paragraph  |

	span := Document getElementById: 'shadowRootSpan' class: HtmlSpanElement.
	shadow := span shadowRoot.
	shadow isNil ifTrue: [
		shadow := span attachShadow: 'open' delegatesFocus: false ].
	self assert: [ shadow class = ShadowRoot ].

	"Create test shadow root document."
	paragraph := ( Document default createElement: 'p' ) textContent: 'New paragraph within shadow root'.
	shadow appendChild: paragraph.
	self assert: [ shadow firstElementChild class = HtmlParagraphElement ].

	"Test properties."

	paragraph forceFocus.
	self assert: [ shadow activeElement class = HtmlParagraphElement ].

	self assert: [ shadow adoptedStyleSheets length = 0 ].
	self assert: [ shadow delegatesFocus not ].
	self assert: [ shadow fullscreenElement = nil ].
	self assert: [ shadow host class = HtmlSpanElement ].
	self assert: [ shadow innerHtml startsWith: '<p ' ].
	self assert: [ shadow mode = 'open' ].
	self assert: [ shadow pointerLockElement = nil ].
	self assert: [ shadow styleSheets length = 0 ].

	"Test methods."

	self assert: [ shadow getAnimations length = 0 ].
	"These won't work if the window is in a scrolled state:
	self assert: [ ( shadow elementFromPoint: 0 @ 0 ) class = HtmlHtmlElement ].
	self assert: [ ( shadow elementsFromPoint: 0 @ 0 ) first class = HtmlHtmlElement ]."
!
