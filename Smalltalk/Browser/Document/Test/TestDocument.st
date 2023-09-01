CLASS TestDocument EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
testProperties
	| document element |
	document := Document default.

	self assert: [ document class = Document ].
	self assert: [ document hasFocus class = Boolean ].
	self assert: [ document activeElement isKindOf: HtmlElement ].

	self assert: [ document head class = HtmlHeadElement ].
	self assert: [ document body class = HtmlBodyElement ].
	document body: document body.

	element := ( document getElementById: 'input' ) focus.
	self assert: [ document activeElement = element ].

	self assert: [ document characterSet = 'UTF-8' ].
	self assert: [ document doctype class = DocumentType ].
	self assert: [ document documentElement class = HtmlHtmlElement ].
	self assert: [ document contentType = 'text/html' ].
	self assert: [ document documentUri startsWith: 'http' ].

	self assert: [ document childElementCount = 1 ].
	self assert: [ document children length = 1 ].
	self assert: [ document children first class = HtmlHtmlElement ].
	self assert: [ document firstElementChild class = HtmlHtmlElement ].
	self assert: [ document lastElementChild class = HtmlHtmlElement ].

	self assert: [ document hidden class = Boolean ].
	self assert: [ #( 'visible' 'hidden' ) includes: document visibilityState ].
	self assert: [ document fullscreenElement = nil ].
	self assert: [ document pointerLockElement = nil ].

	self assert: [ document embeds length = 1 ].
	self assert: [ document forms length = 1 ].
	self assert: [ document images first class = HtmlImageElement ].
	self assert: [ document links first class = HtmlLinkElement ].
	self assert: [ document plugins length = 1 ].
	self assert: [ document scripts first class = HtmlScriptElement ].
	self assert: [ document styleSheets first class = CssStyleSheet ].
!
testHtmlProperties
	| document title |
	document := Document default.

	document cookie: 'chocolateChip'.
	self assert: [ document cookie = 'chocolateChip' ].

	self assert: [ document defaultView class = Window ].

	self assert: [ document designMode = 'off' ].
	document designMode: 'on'.
	self assert: [ document designMode = 'on' ].
	document designMode: 'off'.

	"JS Document.dir is initially an empty string iso one of the allowed values."
	document dir: 'rtl'.
	self assert: [ document dir = 'rtl' ].
	document dir: 'ltr'.
	self assert: [ document dir = 'ltr' ].

	self assert: [ document lastModified length > 8 ].
	self assert: [ document location class = Location ].
	self assert: [ #( 'loading' 'interactive' 'complete' ) includes: document readyState ].
	self assert: [ document referrer = '' or: [ document referrer startsWith: 'http' ] ].

	title := document title.
	self assert: [ title startsWith: 'SmallJS' ].
	document title: title, '!'.
	self assert: [ document title endsWith: '!' ].
	document title: title.

	self assert: [ document url startsWith: 'http' ].
!
testMethods
	| document |
	document := Document default.

	self assert: [ ( document createAttribute: 'myAttr' ) class = Attr ].
	self assert: [ ( document createComment: 'myComment' ) class = Comment ].
	self assert: [ document createDocumentFragment class = DocumentFragment ].
	self assert: [ ( document createElement: 'unknown' ) class = HtmlUnknownElement ].
	self assert: [ ( document createElement: 'p' ) class = HtmlParagraphElement ].
	self assert: [ document createRange class = Range ].
	self assert: [ ( document createTextNode: 'myText' ) class = Text ].
	"These won't work if the window is in a scrolled state:
	self assert: [ ( document elementFromPoint: 0 @ 0 ) class = HtmlHtmlElement ].
	self assert: [ ( document elementsFromPoint: 0 @ 0 ) first class = HtmlHtmlElement ]."
	self assert: [ ( document getElementById: 'element' ) id = 'element' ].
	self assert: [ ( document getElementsByName: 'elementName' ) first name = 'elementName' ].
	self assert: [ ( document getElementsByClassName: 'field' ) first className = 'field' ].
	self assert: [ ( document getElementsByTagName: 'IMG' ) first class = HtmlImageElement ].
	self assert: [ document getSelection class = Selection ].
!
testNodeMethods
	| document newDocument newNode adoptedNode parentNode importedNode |
	document := Document default.

	newDocument := Document new.
	newNode := ( newDocument createElement: 'p' ) textContent: 'Adopted paragraph.'.
	newDocument body appendChild: newNode.
	self assert: [ newDocument body children length = 1 ].

	adoptedNode := document adoptNode: newNode.
	self assert: [ adoptedNode class = HtmlParagraphElement ].
	self assert: [ newDocument body children length = 0 ].

	newNode := ( newDocument createElement: 'p' ) textContent: 'Imported paragraph.'.
	importedNode := document importNode: newNode deep: true.
	self assert: [ importedNode class = HtmlParagraphElement ].

	self assert: [ ( document querySelector: '#documentInfoLabel' ) class = HtmlLabelElement ].
	self assert: [ ( document querySelectorAll: '#documentInfoLabel' ) length = 1 ].
!
testWriting
	| newDocument |

	newDocument := Document new.

	newDocument open.
	newDocument writeln: '<p>Hello world!</p>'.
	newDocument write: '<p>The number is 42.</p>'.
	newDocument close.

	self assert: [ ( newDocument querySelectorAll: 'p' ) length = 2 ].
!
testPage
	| document |
	document := Document default.

	self assert: [ document documentUri startsWith: 'http' ].
	self assert: [ document contentType = 'text/html' ].
	self assert: [ document characterSet = 'UTF-8' ].

	( document getElementById: 'documentInfoLabel' ) textContent:
		document documentUri, ' ', document contentType, ' ', document characterSet.
!
