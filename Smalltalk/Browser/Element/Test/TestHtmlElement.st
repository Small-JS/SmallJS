CLASS TestHtmlElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

testProperties
	| element |

	element := Document getElementById: 'htmlElement'.
	self assert: [ element class = HtmlParagraphElement ].

	self assert: [ element accessKey = 'p' ].
	element accessKey: 'q'.
	self assert: [ element accessKey = 'q' ].
	element accessKey: 'p'.

	self assert: [ element dir = 'ltr' ].
	element dir: 'rtl'.
	self assert: [ element dir = 'rtl' ].
	element dir: 'ltr'.

	self assert: [ element enterKeyHint = 'done' ].
	element enterKeyHint: 'next'.
	self assert: [ element enterKeyHint = 'next' ].
	element enterKeyHint: 'done'.

	self assert: [ element hidden not ].
	element hidden: true.
	self assert: [ element hidden ].
	element hidden: false.

	self assert: [ element inert not ].
	element inert: true.
	self assert: [ element inert ].
	element inert: false.

	self assert: [ element innerText = 'HTML element' ].
	element innerText: 'Changed HTML element'.
	self assert: [ element innerText = 'Changed HTML element' ].
	element innerText: 'HTML element'.

	self assert: [ element outerText = element innerText ].

	self assert: [ element isContentEditable not ].

	self assert: [ element lang = 'en' ].
	element lang: 'nl'.
	self assert: [ element lang = 'nl' ].
	element lang: 'en'.

	self assert: [ element nonce = '' ].
	element nonce: 'whatever'.
	self assert: [ element nonce = 'whatever' ].
	element nonce: ''.

	self assert: [ element offsetTop >= 0 ].
	self assert: [ element offsetLeft >= 0 ].
	self assert: [ element offsetHeight >= 0 ].
	self assert: [ element offsetWidth >= 0 ].

	self assert: [ element style class = CssStyleDeclaration ].

	self assert: [ element tabIndex = -1 ].
	element tabIndex: 0.
	self assert: [ element tabIndex = 0 ].
	element tabIndex: -1.

	self assert: [ element title = 'HTML element title' ].
	element title: 'Changed HTML element title'.
	self assert: [ element title = 'Changed HTML element title' ].
	element title: 'HTML element title'.

	self assert: [ element title = 'HTML element title' ].
!
testMethods
	| document  element |

	document := Document default.
	element := document getElementById: 'htmlElement'.
	self assert: [ element class = HtmlParagraphElement ].

	element forceFocus.
	self assert: [ document activeElement textContent = 'HTML element' ].
	element tabIndex: -1.  "Restore tabIndex state."

	element blur.
	self assert: [ document activeElement class = HtmlBodyElement ].

	"Method click is tested in TestEventTarget."
!
