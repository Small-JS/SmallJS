CLASS TestCustomElementRegistry EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testDefine
	| registry constructor |
	registry := Window default customElements.
	constructor := JsObject fromJs: INLINE 'class extends HTMLElement {}'.
	self assert: [ ( registry get: 'test-define-element' ) isNil ].
	self assert: [ ( registry getName: constructor ) isNil ].

	registry define: 'test-define-element' constructor: constructor.
	self assert: [ ( registry get: 'test-define-element' ) = constructor ].
	self assert: [ ( registry getName: constructor ) = 'test-define-element' ].
!
testCustomElementClass
	"Custom elements are wrapped as HtmlElement, also as host of a shadow root."
	| registry constructor element shadow |
	registry := Window default customElements.
	constructor := JsObject fromJs: INLINE 'class TestClassElement extends HTMLElement {}'.
	registry define: 'test-class-element' constructor: constructor.

	element := Document default createElement: 'test-class-element'.
	self assert: [ element class = HtmlElement ].
	self assert: [ Boolean fromJs: INLINE 'element.js instanceof constructor.js' ].

	shadow := element attachShadow: 'open' delegatesFocus: false.
	self assert: [ shadow host = element ].
	self assert: [ shadow host class = HtmlElement ].
!
testUpgrade
	| registry constructor div jsElement |
	registry := Window default customElements.
	div := Document default createElement: 'div'.
	div innerHtml: '<test-upgrade-element></test-upgrade-element>'.
	jsElement := JsObject fromJs: INLINE 'div.js.firstChild'.
	constructor := JsObject fromJs: INLINE 'class extends HTMLElement {}'.
	registry define: 'test-upgrade-element' constructor: constructor.

	"The element is not connected to the document, so it is not upgraded automatically."
	self assert: [ ( Boolean fromJs: INLINE 'jsElement.js instanceof constructor.js' ) not ].
	registry upgrade: div.
	self assert: [ Boolean fromJs: INLINE 'jsElement.js instanceof constructor.js' ].
!
async testWhenDefined
	| registry constructor definedConstructor |
	registry := Window default customElements.
	constructor := JsObject fromJs: INLINE 'class extends HTMLElement {}'.
	registry define: 'test-when-defined-element' constructor: constructor.
	definedConstructor := await registry whenDefined: 'test-when-defined-element'.
	self assert: [ definedConstructor = constructor ].
!
