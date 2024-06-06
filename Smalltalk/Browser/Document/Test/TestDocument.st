CLASS TestDocument EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

testProperties
	| document element paragraph |
	document := Document new.
	self assert: [ document class = Document ].

	self assert: [ document hasFocus not ].
	self assert: [ document activeElement class = HtmlBodyElement ].

	self assert: [ document head class = HtmlHeadElement ].
	self assert: [ document body class = HtmlBodyElement ].
	document body: document body.

	self assert: [ document characterSet = 'UTF-8' ].
	self assert: [ document doctype class = DocumentType ].
	self assert: [ document documentElement class = HtmlHtmlElement ].
	self assert: [ document contentType = 'text/html' ].
	self assert: [ document documentUri = 'about:blank' ].

	self assert: [ document childElementCount = 1 ].
	self assert: [ document children length = 1 ].
	self assert: [ document children first class = HtmlHtmlElement ].
	self assert: [ document firstElementChild class = HtmlHtmlElement ].
	self assert: [ document lastElementChild class = HtmlHtmlElement ].

	self assert: [ document hidden class = Boolean ].
	self assert: [ #( 'visible' 'hidden' ) includes: document visibilityState ].
	self assert: [ document fullscreenElement = nil ].
	self assert: [ document pointerLockElement = nil ].

	self assert: [ document embeds length = 0 ].
	self assert: [ document forms length = 0 ].
	self assert: [ document images length = 0 ].
	self assert: [ document links length = 0 ].
	self assert: [ document plugins length = 0 ].
	self assert: [ document scripts length = 0 ].
	self assert: [ document styleSheets length = 0 ].
!
testHtmlProperties
	| document |
	document := Document new.

	"This fails for locally created document:
	document cookie: 'name=chocolateChip'.
	self assert: [ document cookie = 'name=chocolateChip' ]."

	self assert: [ document defaultView isNil ].

	self assert: [ document designMode = 'off' ].
	Window isFirefox ifFalse: [
		document designMode: 'on'.
		self assert: [ document designMode = 'on' ] ].
	document designMode: 'off'.

	"JS Document.dir is initially an empty string iso one of the allowed values."
	document dir: 'rtl'.
	self assert: [ document dir = 'rtl' ].
	document dir: 'ltr'.
	self assert: [ document dir = 'ltr' ].

	self assert: [ document lastModified length > 8 ].
	self assert: [ document location isNil ].
	self assert: [ #( 'loading' 'interactive' 'complete' ) includes: document readyState ].
	self assert: [ document referrer = '' or: [ document referrer startsWith: 'http' ] ].

	self assert: [ document title = '' ].
	document title: 'Document title'.
	self assert: [ document title = 'Document title' ].
	document title: ''.

	self assert: [ document url = 'about:blank' ].
!
testMethods
	| document paragraph |
	document := Document new.

	self assert: [ ( document createAttribute: 'myAttr' ) class = Attr ].
	self assert: [ ( document createComment: 'myComment' ) class = Comment ].
	self assert: [ document createDocumentFragment class = DocumentFragment ].
	self assert: [ ( document createElement: 'unknown' ) class = HtmlUnknownElement ].
	self assert: [ ( document createElement: 'p' ) class = HtmlParagraphElement ].
	self assert: [ document createRange class = Range ].
	self assert: [ ( document createTextNode: 'myText' ) class = Text ].

	paragraph := ( document createElement: 'p' )
		id: 'paragraphId';
		className: 'paragraphClass'.
	document body appendChild: paragraph.

	self assert: [ ( document getElementById: 'paragraphId' class: HtmlParagraphElement ) id = 'paragraphId' ].
	self assert: [ ( document getElementsByName: 'paragraphName' ) length = 0 ].
	self assert: [ ( document getElementsByClassName: 'paragraphClass' ) first className = 'paragraphClass' ].
	self assert: [ ( document getElementsByTagName: 'p' ) first class = HtmlParagraphElement ].
	self assert: [ document getSelection isNil ].
!
testNodeMethods
	| document newDocument newNode adoptedNode importedNode |
	document := Document new.

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
!
testQuery
	| document |
	document := Document new.

	document body appendChild: ( document createElement: 'p' ).
	self assert: [ ( document querySelector: 'p' ) class = HtmlParagraphElement ].
	self assert: [ ( document querySelectorAll: 'p' ) length = 1 ].
!
testWriting
	| document |
	document := Document new.

	document open.
	document writeln: '<p>Hello world!</p>'.
	document write: '<p>The number is 42.</p>'.
	document close.

	self assert: [ ( document querySelectorAll: 'p' ) length = 2 ].
!
testPage
	| document |
	document := Document new.

	self assert: [ document documentUri = 'about:blank' ].
	self assert: [ document contentType = 'text/html' ].
	self assert: [ document characterSet = 'UTF-8' ].
!
